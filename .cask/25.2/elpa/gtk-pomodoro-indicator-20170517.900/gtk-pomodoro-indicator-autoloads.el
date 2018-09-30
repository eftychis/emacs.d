;;; gtk-pomodoro-indicator-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "gtk-pomodoro-indicator" "gtk-pomodoro-indicator.el"
;;;;;;  (22950 16757 38682 124000))
;;; Generated autoloads from gtk-pomodoro-indicator.el

(autoload 'gtk-pomodoro-indicator "gtk-pomodoro-indicator" "\
Start the pomodoro timer with PARAMS and return the process.
PARAMS can be either: \"p NUMBER-MINUTES\" or \"b NUMBER-MINUTES\".
The only difference between the two is the icon type.
NUMBER-MINUTES is the number of minutes to count down from.
The timer will self-terminate after it expires.

\(fn PARAMS)" nil nil)

;;;***

;;;### (autoloads nil nil ("gtk-pomodoro-indicator-pkg.el") (22950
;;;;;;  16757 47682 131000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; gtk-pomodoro-indicator-autoloads.el ends here
