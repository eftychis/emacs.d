;;; ace-jump-zap-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "ace-jump-zap" "ace-jump-zap.el" (22980 29580
;;;;;;  628459 467000))
;;; Generated autoloads from ace-jump-zap.el

(autoload 'ace-jump-zap-up-to-char "ace-jump-zap" "\
Call `ace-jump-char-mode' and zap all characters up to the selected character.

\(fn)" t nil)

(autoload 'ace-jump-zap-to-char "ace-jump-zap" "\
Call `ace-jump-char-mode' and zap all characters up to and including the selected character.

\(fn)" t nil)

(autoload 'ace-jump-zap-to-char-dwim "ace-jump-zap" "\
Without PREFIX, call `zap-to-char'.
With PREFIX, call `ace-jump-zap-to-char'.

\(fn &optional PREFIX)" t nil)

(autoload 'ace-jump-zap-up-to-char-dwim "ace-jump-zap" "\
Without PREFIX, call `zap-up-to-char'.
With PREFIX, call `ace-jump-zap-up-to-char'.

\(fn &optional PREFIX)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ace-jump-zap-autoloads.el ends here
