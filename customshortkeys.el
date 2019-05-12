;; duplicate-down
(global-set-key (kbd "M-RET d") 'md-duplicate-down)

;; search ag
(global-set-key (kbd "C-(") (lambda ()
			      (interactive)
			      (let (term dest)
				 (setq term (read-string (format "expression (%s): " (thing-at-point 'word))
					     nil nil (thing-at-point 'word)))
				 (setq dest (read-string (format "directory (%s): " (thing-at-point 'word))
					     nil nil (thing-at-point 'word)))
		(ag term dest))))
(global-set-key (kbd "C-)") (lambda ()
		(interactive 2)
		(projectile-ag)))

;; writeroom-mode-global
(global-set-key (kbd "M-RET r") 'writeroom-mode)
;; mc-edit lines
(global-set-key (kbd "M-RET e") 'mc/edit-lines)
;; (define-key global-key-binding (kbd "<C-'") 'mc-edit-lines)
;; (global-set-key (kbd "C-'") 'mc/mark-next-sexps)
;; (global-set-key (kbd "C-\"") 'mc/mark-next-sexps)
;; Follow File (for imports, includes, input etc).
(global-set-key (kbd "M-RET f") 'find-file-at-point)


(global-set-key (kbd "M-RET >") 'mc/mark-next-like-this)
(global-set-key (kbd "M-RET <") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-RET C->") 'mc/mark-all-like-this)
(global-set-key (kbd "M-RET '") 'mc/edit-lines)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; v2

;; writeroom-mode-global
(global-set-key (kbd "C-c r") 'writeroom-mode)
;; mc-edit lines
(global-set-key (kbd "C-c e") 'mc/edit-lines)
;; (define-key global-key-binding (kbd "<C-'") 'mc-edit-lines)
(global-set-key (kbd "C-c '") 'mc/mark-next-sexps)
(global-set-key (kbd "C-c \"") 'mc/mark-next-sexps)


(global-set-key (kbd "C-c c >") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c c <") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c c C->") 'mc/mark-all-like-this)

;;;;;;;;;;;;
;; swap windows
(global-set-key (kbd "C-c s") 'swap-buffers)
;; fast narrrow
(global-set-key (kbd "C-c n") 'narrow-to-region)

;; duplicate the current line or region
(global-set-key (kbd "C-c d") 'md-duplicate-down)
;;(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

;; search with google
(global-set-key (kbd "C-c g") 'google-this)
;; parenthesis related commands
;;(global-set-key (kbd "") `paren-face)


;; smartparens-mode keybindings
(global-set-key (kbd "C-c p k") 'sp-kill-sexp)
(global-set-key (kbd "C-c p u") 'sp-unwrap-sexp)
(global-set-key (kbd "C-c p r") 'sp-raise-sexp)
(global-set-key (kbd "C-c p n") 'sp-next-sexp)
(global-set-key (kbd "C-c p p") 'sp-previous-sexp)
(global-set-key (kbd "C-c p d") 'sp-down-sexp)


(require 'key-chord)
(key-chord-mode t)
;; from: https://www.emacswiki.org/emacs/KeyChord
;; Max time delay between two key presses to be considered a key chord
(setq key-chord-two-keys-delay 0.1) ; default 0.1

;; Max time delay between two presses of the same key to be considered a key chord.
;; Should normally be a little longer than `key-chord-two-keys-delay'.
(setq key-chord-one-key-delay 0.15)
;;
;;(global-set-key (kbd "C-@") 'er/expand-region)
(key-chord-define-global "fs" 'er/expand-region)
(key-chord-define-global "ds" 'md-duplicate-down)
(key-chord-define-global "sd" 'fit-window-to-buffer)
