;;; synosaurus.el --- An Emacs frontend for thesauri

;; Copyright (C) 2015  Hans-Peter Deifel

;; Author: Hans-Peter Deifel <hpdeifel@gmx.de>
;; Keywords: wp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; An extensible thesaurus supporting lookup and substitution.

;; You can choose between multiple backends. Current backends include
;; wordnet and openthesaurus, but it's easy to add your own.

;; Use `synosaurus-lookup' for lookup and `synosaurus-choose-and-replace'
;; to replace the word under cursor.

;; Customization can be done by M-x customize-group synosaurus

;;; Code:

(require 'button)
(require 'cl-lib)
(require 'thingatpt)
(require 'ido)

(declare-function popup-menu* "popup")

(defgroup synosaurus nil "An extensible thesaurus mode"
  :group 'convenience
  :group 'text)

(defcustom synosaurus-choose-method 'ido
  "The way of querying the user for word replacements.

This is used in `synosaurus-choose-and-replace'.

Valid values are:

  - popup   : Use popup.el to show a nice popup with alternatives.
              The popup.el library must be installed for this to work.
  - ido     : Use IDO to read an alternative with completion.
  - default : Use normal minibuffer completion."
  :group 'synosaurus
  :type '(choice (const :tag "popup.el" popup)
                 (const :tag "Ido" ido)
                 (const :tag "Completing read" default)))

(defcustom synosaurus-backend 'synosaurus-backend-wordnet
  "The backend for the thesaurus.

Built-in backends are

  - synosaurus-backend-wordnet        An english offline thesaurus
  - synosaurus-backend-openthesaurus  A german online thesaurus"
  :group 'synosaurus
  :type  '(choice (const :tag "Wordnet" synosaurus-backend-wordnet)
                  (const :tag "OpenThesaurus" synosaurus-backend-openthesaurus)
                  (function :tag "Other")))
(make-variable-buffer-local 'synosaurus-backend)

(defcustom synosaurus-prefix (kbd "C-c s")
  "Synosaurus keymap prefix."
  :group 'synosaurus
  :type 'string)

(defun synosaurus-internal-lookup (word)
  "Call current backend with `WORD'."
  (if synosaurus-backend
      (funcall synosaurus-backend word)
    (error "No thesaurus lookup function specified")))

(defun synosaurus-strip-properties (string)
  "Remove text properties from `STRING'."
  (set-text-properties 0 (length string) nil string)
  string)

(defun synosaurus-guess-default ()
  "Return region or word under cursor."
  (if (use-region-p)
      (buffer-substring-no-properties (region-beginning) (region-end))
    (synosaurus-strip-properties (thing-at-point 'word))))

(defvar synosaurus-history nil)

(defun synosaurus-interactive ()
  "Ask the user for a word (with default)."
  (let* ((default (synosaurus-guess-default))
         (res (read-string (if default
                               (format "Word (default %s): " default)
                             "Word: ")
                           nil 'synosaurus-history)))
    (list
     (if (not (string= res ""))
         res
       default))))

(defun synosaurus-button-action (arg)
  (synosaurus-lookup (button-label arg)))

(defvar synosaurus-list-mode-map
  (let ((map (copy-keymap button-buffer-map)))
    (set-keymap-parent map special-mode-map)
    map))

(define-derived-mode synosaurus-list-mode special-mode "Synosaurus")

;;;###autoload
(defun synosaurus-lookup (word)
  "Lookup `WORD' in the thesaurus.

Queries the user for a word and looks it up in a thesaurus using
`synosaurus-backend'.

The resulting synonym list will be shown in a new buffer, where
the words are clickable to look them up instead of the original
word."
  (interactive (synosaurus-interactive))
  (let ((inhibit-read-only t))
    (with-current-buffer (get-buffer-create "*Synonyms List*")
      (erase-buffer)
      (insert
       (propertize (format "Synonyms of %s:\n\n" word)
                   'face 'success))
      (cl-flet ((ins (syn)
                  (unless (string= word syn)
                    (insert " ")
                    (insert-text-button syn
                                        'action 'synosaurus-button-action)
                    (insert "\n"))))
        (dolist (syn (synosaurus-internal-lookup word))
          (if (not (listp syn))
              (ins syn)
            (dolist (syn2 syn)
              (ins syn2))
            (insert "\n"))))
      (goto-char (point-min))
      (condition-case nil (forward-button 1 t nil)
        (error nil))
      (synosaurus-list-mode)))
  (display-buffer "*Synonyms List*"))

(defun synosaurus-choose (list)
  "Choose among a `LIST' of values."
  (let ((completion-prompt "Replacement: "))
   (pcase synosaurus-choose-method
     (`popup (unless (require 'popup nil t)
               (error "Please install popup.el to use the popup choose-method"))
             (popup-menu* list))
     (`ido (require 'ido)
           (ido-completing-read completion-prompt list))
     (_ (completing-read completion-prompt list)))))

;;;###autoload
(defun synosaurus-choose-and-replace ()
  "Replace the word under the cursor by a synonyme.

Look up the word in the thesaurus specified by
`synosaurus-backend', let the user choose an alternative
and replace the original word with that."
  (interactive "")
  (let* ((word (synosaurus-guess-default))
         (syns
          (cl-loop for syn in (synosaurus-internal-lookup word)
                   if (listp syn) append syn
                   else append (list syn))))
    (if (null syns) (message "No synonyms found for %s" word)
      (let ((res (synosaurus-choose syns)))
        (when res
          (if (use-region-p)
              (delete-region (region-beginning) (region-end))
            (delete-region (beginning-of-thing 'word)
                           (end-of-thing 'word)))
          (insert res))))))

(defvar synosaurus-command-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "l") 'synosaurus-lookup)
    (define-key map (kbd "r") 'synosaurus-choose-and-replace)
    map))
(fset 'synosaurus-command-map synosaurus-command-map)

(defvar synosaurus-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map synosaurus-prefix synosaurus-command-map)
    map))

;;;###autoload
(define-minor-mode synosaurus-mode
  "Minor mode for thesaurus lookups.

When called interactively, toggle `synosaurus-mode'. With prefix
ARG, enable `synosaurus-mode' if ARG is positive, otherwise
disable it.

When called from Lisp, enable `synosaurus-mode', if ARG is
omitted, nil or positive. If ARG is `toggle', toggle
`synosaurus-mode'. Otherwise behave as if called interactively.

The thesaurus backend can be configured with
`synosaurus-backend'.

\\{synosaurus-mode-map}"
  :lighter " Syn"
  :keymap synosaurus-mode-map
  :group 'synosaurus)

(provide 'synosaurus)
;;; synosaurus.el ends here
