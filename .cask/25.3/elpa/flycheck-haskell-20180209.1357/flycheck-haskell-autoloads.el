;;; flycheck-haskell-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "flycheck-haskell" "flycheck-haskell.el" (23173
;;;;;;  59190 89756 683000))
;;; Generated autoloads from flycheck-haskell.el

(autoload 'flycheck-haskell-setup "flycheck-haskell" "\
Setup Haskell support for Flycheck.

If the current file is part of a Cabal project, configure
Flycheck to take the module paths of the Cabal projects into
account.

Also search for Cabal sandboxes and add them to the module search
path as well.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("flycheck-haskell-pkg.el") (23173 59190
;;;;;;  81756 724000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; flycheck-haskell-autoloads.el ends here
