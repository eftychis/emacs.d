;;; eldoro-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "eldoro" "eldoro.el" (22836 45385 0 0))
;;; Generated autoloads from eldoro.el

(autoload 'eldoro "eldoro" "\
Start Eldoro on the current `org-mode' heading.  If Eldoro is
already running bring its buffer forward.

If Eldoro has already been started and this function is called
from an `org-mode' buffer, prompt for permission to reset the
Eldoro tasks.  With a prefix argument force a reset without
prompting.

\(fn &optional FORCE-RESET)" t nil)

;;;***

;;;### (autoloads nil nil ("eldoro-pkg.el") (22836 45385 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; eldoro-autoloads.el ends here
