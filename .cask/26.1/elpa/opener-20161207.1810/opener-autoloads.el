;;; opener-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "opener" "opener.el" (0 0 0 0))
;;; Generated autoloads from opener.el

(autoload 'opener-try-open "opener" "\
Try to open URL-OR-FILE appropriately.
This means a file-like URL in a buffer, any other URL in a browser
and a FILE as a normal file.
When FORCE-BUFFER non-nil, then actual URL is always opened in buffer.
CALLBACK gets executed in the not-url case.

\(fn URL-OR-FILE &optional FORCE-BUFFER CALLBACK)" nil nil)

(autoload 'opener-open-at-point "opener" "\
Opens URL or FILE at point.

\(fn)" t nil)

(autoload 'opener-open "opener" "\
Open a URL-OR-FILE in buffer, with FORCE-BUFFER it opens URL in a buffer.
This means that it doesn't perform the file-like-url check to determine whether
to open url in buffer (= file-like-url t) or in a browser (= file-like-url
nil).

\(fn URL-OR-FILE FORCE-BUFFER)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "opener" '("opener-")))

;;;***

;;;### (autoloads nil nil ("opener-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; opener-autoloads.el ends here
