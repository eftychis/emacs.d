;;; company-math-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "company-math" "company-math.el" (22836 46105
;;;;;;  0 0))
;;; Generated autoloads from company-math.el

(autoload 'company-latex-commands "company-math" "\
Company backend for latex commands.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(autoload 'company-math-symbols-latex "company-math" "\
Company backend for LaTeX mathematical symbols.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(autoload 'company-math-symbols-unicode "company-math" "\
Company backend for insertion of Unicode mathematical symbols.
See the unicode-math page [1] for a list of fonts that have a
good support for mathematical symbols. Unicode provides only a
limited range of sub(super)scripts; see the wikipedia page [2]
for details.

 [1] http://ftp.snt.utwente.nl/pub/software/tex/help/Catalogue/entries/unicode-math.html
 [2] https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; company-math-autoloads.el ends here
