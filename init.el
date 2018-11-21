(put 'set-goal-column 'disabled nil)
(setq package-enable-at-startup nil) (package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
;;
(setq sage-shell:sage-root "/Applications/Sage-6.5.app/Contents/MacOS/Sage")

(require 'cask "~/.emacs.d/.cask/25.1/elpa/cask-20161024.1205/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)
(require 'color)
(require 'benchmark-init)

(require 'auto-complete-config)
(ac-config-default)
(require 'go-autocomplete)
(require 'auto-complete)
(global-auto-complete-mode nil)
(package-initialize)

(require 'auto-complete-config)
(ac-config-default)
;; Setup Icicles

;;(require 'icicles)
;;(icy-mode t)
(require 'icicles)
(icy-mode t)
(require 'god-mode)
(require 'smartparens)
(smartparens-global-mode t)

(require 'yasnippet)
(yas-global-mode t)
(require 'semantic)
(semantic-mode t)
(global-ede-mode 1)
(require 'flycheck)
(flycheck-mode t)
(require 'ido)
(ido-mode t)
;;; activate ecb
(require 'ecb)
;;(require 'ecb-autoloads)
(setq stack-trace-on-error t)
(setq ecb-version-check nil)
(setq ecb-layout-name "left6")
(setq ecb-show-sources-in-directories-buffer 'always)

(require 'company)
(global-company-mode t)

(require 'rust-mode)
(require 'racer)

(package-install 'intero)
;; load files
(load-file (expand-file-name "extra-buffer-functions.el" user-emacs-directory))
(load-file (expand-file-name "tla-mode.el" user-emacs-directory))
(load-file (expand-file-name "cheat-sh.el" user-emacs-directory))
(load-file (expand-file-name "britanize.el" user-emacs-directory))
;; completion popup is a bit slow: tuning the delay down a notch
(setq company-idle-delay 0.3)
;(setq company-tooltip-align-annotations t)
;; functions - TODO : move them somewhere seperately.
(defun my:ac-c-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  ;; running gcc -xc++ -E -v -
  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include")
  )
(add-hook 'c++-mode-hook 'my:ac-c-init)
(add-hook 'c-mode-hook (lambda ()
			 (setq comment-style 'extra-line)))
(add-hook 'c-mode-hook 'my:ac-c-init)
(add-hook 'c-mode-hook 'google-set-c-style)
;;we want a saner identation style for C
(defun c-lineup-arglist-tabs-only (ignored)
      "Line up argument lists by tabs, not spaces"
      (let* ((anchor (c-langelem-pos c-syntactic-element))
	     (column (c-langelem-2nd-pos c-syntactic-element))
	     (offset (- (1+ column) anchor))
	     (steps (floor offset c-basic-offset)))
	(* (max steps 1)
	   c-basic-offset)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    ;; Add kernel style
	    (c-add-style
	     "linux-tabs-only"
	     '("linux" (c-offsets-alist
			(arglist-cont-nonempty
			 c-lineup-gcc-asm-reg
			 c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode t)
	    (setq show-trailing-whitespace t)
	    (c-set-style "linux-tabs-only")
	    ))


(add-hook 'LaTeX-mode-hook (lambda ()
			     (require 'auto-complete-auctex)
			     (add-to-list 'ac-sources 'ac-source-math-unicode)
			     (add-to-list 'ac-sources 'ac-source-math-latex)
			     ))
(add-hook 'TeX-mode-hook (lambda ()
			     (require 'auto-complete-auctex)
			     (add-to-list 'ac-sources 'ac-source-math-unicode)
			     (add-to-list 'ac-sources 'ac-source-math-latex)
			     ))


(defun my:ac-semantic()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )

;; start winner mode if valid for current setup
(when (fboundp 'winner-mode)
        (winner-mode 1))

;; add semantic with c and haskell -- TODO maybe I should add it in all modes?
(add-hook 'c-mode-common-hook 'my:ac-semantic)
(add-hook 'haskell-mode-hook 'my:ac-semantic)
(require 'hindent)
(add-hook 'haskell-mode-hook #'hindent-mode)
(add-hook 'haskell-mode-hook #'my-haskell-brittany-mode-hook)

;;(define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def)
(setq haskell-tags-on-save t)
(require 'speedbar)
(speedbar-add-supported-extension ".hs")
;; hooks be here
;; highlighting
;;(add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
;;(add-hook 'font-lock-mode-hook 'hc-trailing-whitespace)
;;(add-hook 'font-lock-mode-hook 'hc-hard-space)

;; N.B. Revisit this
;; haskell - related
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'intero-mode)

(defun my-intero-check-hook ()
  (with-eval-after-load 'intero
    (with-eval-after-load 'flycheck
      (flycheck-add-next-checker 'intero
				 '(warning . haskell-hlint))
      )
    )
  (local-set-key (kbd "M-TAB") 'intero-company)
 )

(add-hook 'haskell-mode-hook 'my-intero-check-hook)


; === 
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-to-list 'completion-ignored-extensions ".hi")
;(speedbar-add-supported-extension ".hs")
(add-hook 'rust-mode-hook 'racer-mode)

;(load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
(defun my-go-mode-hook ()
; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
;; Gofmt before saving
(add-hook 'before-save-hook 'gofmt-before-save)
					;compile command to run go build
(if (not (string-match "go" compile-command))
    (set (make-local-variable 'compile-command)
	   "go build -v && go test -v && go vet"))
					; Godef p key binding
(local-set-key (kbd "M-.") 'godef-p))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; context hooks
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face t)))))
;; context hooks
(add-hook 'go-mode-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("\\<\\(FIXME\\|TODO\\|BUG\\|TASK\\)" 1 font-lock-warning-face t)))))
;; context hooks
(add-hook 'haskell-mode-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("\\<\\(FIXME\\|TODO\\|BUG\\|TASK\\)" 1 font-lock-warning-face t)))))
;; context hooks
(add-hook 'TeX-mode-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("\\<\\(FIXME\\|TODO\\|BUG\\|TASK\\)" 1 font-lock-warning-face t)))))


(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
(setq reftex-save-parse-info t) ; I didn't know I had it either in my config

(show-paren-mode 1) ;; match parentheses always.

;;;; testing below function
(eval-after-load 'reftex-vars; Is this construct really needed?
      '(progn
	 (setq reftex-cite-prompt-optional-args t); Prompt for empty optional arguments in cite macros.
	 ;; Make RefTeX interact with AUCTeX, http://www.gnu.org/s/auctex/manual/reftex/AUCTeX_002dRefTeX-Interface.html
	 (setq reftex-plug-into-AUCTeX t)
	 ;; So that RefTeX also recognizes \addbibresource. Note that you
	 ;; can't use $HOME in path for \addbibresource but that "~"
	 ;; works.
	 (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
					;     (setq reftex-default-bibliography '("UNCOMMENT LINE AND INSERT PATH TO YOUR BIBLIOGRAPHY HERE")); So that RefTeX in Org-mode knows bibliography
	 (setcdr (assoc 'caption reftex-default-context-regexps) "\\\\\\(rot\\|sub\\)?caption\\*?[[{]"); Recognize \subcaptions, e.g. reftex-citation
	 (setq reftex-cite-format; Get ReTeX with biblatex, see http://tex.stackexchange.com/questions/31966/setting-up-reftex-with-biblatex-citation-commands/31992#31992
	       '((?t . "\\textcite[]{%l}")
		 (?a . "\\autocite[]{%l}")
		 (?c . "\\cite[]{%l}")
		 (?s . "\\smartcite[]{%l}")
		 (?f . "\\footcite[]{%l}")
		 (?n . "\\nocite{%l}")
		 (?b . "\\blockcquote[]{%l}{}")))))


;; (setq reftex-use-external-file-finders t)
;; (setq reftex-external-file-finders
;;       '(("tex" . "/path/to/kpsewhich -format=.tex %f")
;; 	("bib" . "/path/to/kpsewhich -format=.bib %f")))

;; Fontification (remove unnecessary entries as you notice them) http://lists.gnu.org/archive/html/emacs-orgmode/2009-05/msg00236.html http://www.gnu.org/software/auctex/manual/auctex/Fontification-of-macros.html
(setq font-latex-match-reference-keywords
      '(
	;; biblatex
	("printbibliography" "[{")
	("addbibresource" "[{")
	;; Standard commands
	;; ("cite" "[{")
	("Cite" "[{")
	("parencite" "[{")
	("Parencite" "[{")
	("footcite" "[{")
	("footcitetext" "[{")
	;; ;; Style-specific commands
	("textcite" "[{")
	("Textcite" "[{")
	("smartcite" "[{")
	("Smartcite" "[{")
	("cite*" "[{")
	("parencite*" "[{")
	("supercite" "[{")
					; Qualified citation lists
	("cites" "[{")
	("Cites" "[{")
	("parencites" "[{")
	("Parencites" "[{")
	("footcites" "[{")
	("footcitetexts" "[{")
	("smartcites" "[{")
	("Smartcites" "[{")
	("textcites" "[{")
	("Textcites" "[{")
	("supercites" "[{")
	;; Style-independent commands
	("autocite" "[{")
	("Autocite" "[{")
	("autocite*" "[{")
	("Autocite*" "[{")
	("autocites" "[{")
	("Autocites" "[{")
	;; Text commands
	("citeauthor" "[{")
	("Citeauthor" "[{")
	("citetitle" "[{")
	("citetitle*" "[{")
	("citeyear" "[{")
	("citedate" "[{")
	("citeurl" "[{")
	;; Special commands
	("fullcite" "[{")))

(setq font-latex-match-textual-keywords
      '(
	;; biblatex brackets
	("parentext" "{")
	("brackettext" "{")
	("hybridblockquote" "[{")
	;; Auxiliary Commands
	("textelp" "{")
	("textelp*" "{")
	("textins" "{")
	("textins*" "{")
	;; supcaption
	("subcaption" "[{")))

(setq font-latex-match-variable-keywords
      '(
	;; amsmath
	("numberwithin" "{")
	;; enumitem
	("setlist" "[{")
	("setlist*" "[{")
	("newlist" "{")
	("renewlist" "{")
	("setlistdepth" "{")
	        ("restartlist" "{")))
;;;; end testing
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LateX-mode-hook #'(add-to-list 'TeX-style-list "latex2e"))
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-allow-automatic-rescan t)
(add-hook 'TeX-mode-hook 'turn-on-reftex)
(add-hook 'TeX-mode-hook
	  (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
			  (cons "\\(" "\\)"))))
;; imenu hook for reftex
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)


;; variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" org-agenda-files
     (quote
      ("~/WriteUps/prs.org" "~/WriteUps/todo.org" "~/WriteUps/personal/mytodos.org" "~/WriteUps/personal/today.org")))))
 '(package-selected-packages
   (quote
    (matlab-mode ace-mc smart-cursor-color hi2 helm-ag-r helm-ag hindent projectile-codesearch hayoo dante pomodoro redtick tomatinho gscholar-bibtex gtags gtk-pomodoro-indicator eagle-eye wrap-region writegood-mode wolfram xkcd function-args irony rtags benchmark-init cff guru-mode package-build shut-up git commander pallet wgrep sx ace-jump-mode alert async auctex avy biblio-core color-theme company concurrent connection ctable dash deferred diminish direx edit-at-point epic epl f find-file-in-project flycheck gh ghc git-commit gntp go-eldoc go-mode go-rename haskell-mode header2 helm-bibtex helm-core helm-swoop highlight-indentation ht html-to-markdown htmlize http-post-simple hydra key-chord let-alist lib-requires link log4e logito magit-popup markdown-mode marshal math-symbol-lists multiple-cursors noflet org org-mac-link parsebib pcache pkg-info popup pos-tip pyvenv request seq swiper visual-fill-column with-editor yaoddmuse yasnippet magit-rockstar org-magit auto-complete latex-extra latex-pretty-symbols opener go-guru rpn-calc s s-buffer showkey biblio helm magit projectile z3-mode x-dict writeroom-mode window-numbering window-layout warm-night-theme use-package textmate synosaurus synonyms synonymous switch-window swap-buffers sublimity smooth-scrolling smex smartparens sage-shell-mode ruby-tools rspec-mode python-environment projectile-speedbar outline-magic orglue org-ref org-readme org-projectile org-pomodoro move-dup monokai-theme mc-jump mc-extras magit-gh-pulls latex-unicode-math-mode latex-preview-pane latex-math-preview jazz-theme ivy isearch-symbol-at-point isearch+ intero iedit idomenu ido-at-point icicles ibuffer-git highlight-chars helm-make helm-ispell helm-hoogle helm-gtags helm-c-yasnippet ham-mode hackernews gotest google-translate google-this google golint god-mode go-projectile go-dlv go-direx go-complete go-autocomplete gitty git-blame ggtags fm flyspell-popup flyspell-correct flycheck-perl6 flycheck-haskell flycheck-ghcmod flycheck-color-mode-line flycheck-cask epc eno elscreen elpy eldoro ecb dictionary cpputils-cmake counsel company-math company-go company-ghci company-ghc company-cmake company-cabal company-c-headers company-auctex colorsarenice-theme color-theme-twilight color-theme-tango color-theme-monokai cdlatex auto-complete-auctex ag ace-link ace-jump-zap ace-isearch ace-flyspell ac-python ac-math ac-ispell ac-html ac-helm ac-haskell-process ac-etags ac-emoji ac-clang ac-c-headers)))
 '(rainbow-identifiers-cie-l*a*b*-lightness 30)
 '(rainbow-identifiers-cie-l*a*b*-saturation 35)
 '(safe-local-variable-values
   (quote
    ((TeX-master . pitch\.tex)
     (TeX-master . \.\./pitch\.tex)
     (reftex-default-ibliography "../bib.bib")
     (reftex-default-bibliography "bib.bib")))))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )

;; irony mode
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun replace-irony-with-irony-completion-hook ()
      (define-key irony-mode-map [remap completion-at-point]
	'irony-completion-at-point-async)
      (define-key irony-mode-map [remap complete-symbol]
	'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'replace-irony-with-irony-completion-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; company "complete anything" hooks
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-irony)
(company-irony t)
(setq company-idle-delay              nil
	    company-minimum-prefix-length   2
	    company-show-numbers            t
	    company-tooltip-limit           20
	    company-dabbrev-downcase        nil
	    company-backends                '((company-irony company-gtags))
	    )

(setq molokai-theme-kit t)
;;(load-theme 'monokai-theme t)
;;(prelude-require-package 'ace-jump-mode)
;;(require 'ace-jump-mode)
(define-key global-map (kbd "M-j") 'ace-jump-mode)
(put 'upcase-region 'disabled nil)
(window-numbering-mode t)
;; ORG mode configuration
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; Setting org-mode's calendar source files.
(setq org-log-done t)
(setq org-agenda-files (list "~/WriteUps/todo.org"
			     "~/WriteUps/personal/mytodos.org"
			     "~/WriteUps/personal/today.org"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(ac-config-default)
(ac-flyspell-workaround)
;; latex vars
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;; no exempt buffers for god mode
(setq god-exempt-major-modes nil)
(setq god-exempt-predicates nil)

(setq default-frame-alist '((cursor-color . "white")))

;; (require 'cursor-chg)  ; Load the library
;; (toggle-cursor-type-when-idle 1) ; Turn on cursor change when Emacs is idle
;; (change-cursor-mode 1) ; Turn on change for overwrite, read-only, and input mode
(require 'smart-cursor-color)
(setq smart-cursor-color-mode t)

;; (defun my-update-cursor ()
;;       (setq cursor-type (if (or god-global-mode buffer-read-only)
;; 			    'box
;; 			  'bar)))

;; (setq default-frame-alist '((cursor-color . "white")))
;; (add-hook 'god-mode-enabled-hook 'my-update-cursor)
;; (add-hook 'god-mode-disabled-hook 'my-update-cursor)

;; (defun c/god-mode-update-cursor ()
;;   (let ((limited-colors-p (> 257 (length (defined-colors)))))
;;     (cond (god-mode (progn
;; 			    (set-face-background 'mode-line (if limited-colors-p "white" "#e9e2cb"))
;; 			    (set-face-background 'mode-line-inactive (if limited-colors-p "white" "#e9e2cb"))))
;; 	  (t (progn
;; 	       (set-face-background 'mode-line (if limited-colors-p "black" "#0a2832"))
;; 	       (set-face-background 'mode-line-inactive (if limited-colors-p "black" "#0a2832")))))))
;; (add-hook 'god-mode-enabled-hook 'c/god-mode-update-cursor)
;; ;; god mode update cursor and line background
(defun hook-update-cursor-orange ()
	;; (cond ((or (bound-and-true-p god-mode)
	;; 	   (bound-and-true-p god-global-mode))
  (set-cursor-color "lime green")
  (set-face-attribute 'cursor "red")
  (setq cursor-type 'bar)
  )

;; (t (set-cursor-color "dark orange"))))
(defun hook-update-cursor-grey ()
  (set-cursor-color "dark orange")
  (setq cursor-type 'hbar)
  )

(add-hook 'god-mode-enabled-hook 'hook-update-cursor-orange)
(add-hook 'god-mode-disabled-hook 'hook-update-cursor-grey)

;; (add-hook 'buffer-list-update-hook 'hook-update-cursor)

;; (defun my-update-cursor ()
;;       (setq cursor-type (if (or god-local-mode buffer-read-only)
;; 			    'box
;; 			  'bar)))
;; (add-hook 'god-mode-enabled-hook 'my-update-cursor)
;; (add-hook 'god-mode-disabled-hook 'my-update-cursor)

;; (defun set-modeline-color-grey ()
;;       (set-face-background 'mode-line "#b5b5b5")
;;       (set-face-background 'mode-line-inactive "#b5b5b5"))
;; (defun set-modeline-color-champagne ()
;;   (set-face-background 'mode-line "#f6eabe")
;;   (set-face-background 'mode-line-inactive "#f6eabe"))
;; (add-hook 'god-mode-enabled-hook 'set-modeline-color-champagne)
;; (add-hook 'god-mode-disabled-hook 'set-modeline-color-grey)

;; disable god mode on overwrite
(defun god-toggle-on-overwrite ()
      "Toggle god-mode on overwrite-mode."
      (if (bound-and-true-p overwrite-mode)
	  (god-local-mode-pause)
	(god-local-mode-resume)))

(add-hook 'overwrite-mode-hook 'god-toggle-on-overwrite)

;; my shortcuts
(global-set-key (kbd "M-[") 'delete-other-windows) ; expand current pane
(global-set-key (kbd "M-]") 'split-window-horizontally) ; split pane top/bottom
(global-set-key (kbd "M-p") 'delete-window) ; close current pane
(global-set-key (kbd "M-s") 'other-window) ; cursorag to other pane
(global-set-key (kbd "M-x") 'smex) ; cursorag to other pane
(global-set-key (kbd "M-g") 'goto-line)        ;
;;(global-set-key (kbd "M-M-c") 'calendar)        
(global-set-key (kbd "M-RET g g") 'god-mode)
(global-set-key (kbd "C-_") 'god-mode-all)
;;(global-set-key [(shift right)] 'god-mode-all)
(define-key god-local-mode-map (kbd ".") 'repeat)
;; duplicate-down
(global-set-key (kbd "M-RET d") 'md/duplicate-down)

;; search ag
(global-set-key (kbd "C-(") (lambda ()
			      (interactive)
			      (let (term dest)
				 (setq term (read-string (format "word (%s): " (thing-at-point 'word))
					     nil nil (thing-at-point 'word)))
				 (setq dest (read-string (format "word (%s): " (thing-at-point 'word))
					     nil nil (thing-at-point 'word)))
		(ag term dest))))
(global-set-key (kbd "C-)") (lambda ()
		(interactive)
		(projectile-ag)))

;; writeroom-mode-global
(global-set-key (kbd "M-RET r") 'writeroom-mode)
;; mc-edit lines
(global-set-key (kbd "M-RET e") 'mc/edit-lines)
;; (define-key global-key-binding (kbd "<C-'") 'mc-edit-lines)
;; (global-set-key (kbd "C-'") 'mc/mark-next-sexps)
;; (global-set-key (kbd "C-\"") 'mc/mark-next-sexps)
;; ', "
;; set winner mode
(global-set-key (kbd "C-c <right>") 'winner-redo)
(global-set-key (kbd "C-c <left>") 'winner-undo) 
;; You know, like Readline.
(global-set-key (kbd "M-RET b") 'backward-kill-word)
;;(global-set-key (kbd "M-RET m p") 'smartparens-mode)
;;(global-set-key (kbd "M-RET r") 'global-writeroom-mode)

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)
;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-i") 'ido-imenu)
;; Follow File (for imports, includes, input etc).
(global-set-key (kbd "M-RET f") 'find-file-at-point)
;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
;; Fetch the contents at a URL, display it raw.
(global-set-key (kbd "C-x C-h") 'url-view-url)

;; Help should search more than just commands
(global-set-key (kbd "C-h a") 'apropos)

;; Should be able to eval-and-replace anywhere.
(global-set-key (kbd "C-c e") 'eval-and-replace)

;; Magit rules!
(global-set-key (kbd "M-RET g s") 'magit-status)
;; swap windows
(global-set-key (kbd "C-c s") 'swap-windows)
;; duplicate the current line or region
(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)
;; search with google
(global-set-key (kbd "C-c g") 'google-this)
;; parenthesis related commands
;;(global-set-key (kbd "") `paren-face) 

;;
;; transpose rules
(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(global-set-key [(meta up)] 'transpose-line-up)
(global-set-key [(meta down)] 'transpose-line-down)

(global-set-key (kbd "M-RET >") 'mc/mark-next-like-this)
(global-set-key (kbd "M-RET <") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-RET C->") 'mc/mark-all-like-this)
(global-set-key (kbd "M-RET '") 'mc/edit-lines)

;; Borrowed from xah
;; TODO: move them into a separate file if they work fine
(defun xah-forward-block (&optional n)
        "Move cursor beginning of next text block.
A text block is separated by blank lines.
This command similar to `forward-paragraph', but this command's behavior is the same regardless of syntax table.
URL `http://ergoemacs.org/emacs/emacs_move_by_paragraph.html'
Version 2016-06-15"
	(interactive "p")
	(let ((n (if (null n) 1 n)))
	  (search-forward-regexp "\n[\t\n ]*\n+" nil "NOERROR" n)))

(defun xah-backward-block (&optional n)
  "Move cursor to previous text block.
See: `xah-forward-block'
URL `http://ergoemacs.org/emacs/emacs_move_by_paragraph.html'
Version 2016-06-15"
	(interactive "p")
	(let ((n (if (null n) 1 n))
	      (-i 1))
	  (while (<= -i n)
	    (if (search-backward-regexp "\n[\t\n ]*\n+" nil "NOERROR")
		(progn (skip-chars-backward "\n\t "))
	      (progn (goto-char (point-min))
		     (setq -i n)))
	          (setq -i (1+ -i)))))

(defun xah-beginning-of-line-or-block (&optional n)
  "Move cursor to beginning of line, or beginning of current or previous text block.
 (a text block is separated by blank lines)
URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (if (equal n 1)
        (if (or (equal (point) (line-beginning-position))
                (equal last-command this-command )
                ;; (equal last-command 'xah-end-of-line-or-block )
                )
            (xah-backward-block n)
          (beginning-of-line))
      (xah-backward-block n))))

(defun xah-end-of-line-or-block (&optional n)
  "Move cursor to end of line, or end of current or next text block.
 (a text block is separated by blank lines)
URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (if (equal n 1)
        (if (or (equal (point) (line-end-position))
                (equal last-command this-command )
                ;; (equal last-command 'xah-beginning-of-line-or-block )
                )
            (xah-forward-block)
          (end-of-line))
      (progn (xah-forward-block n)))))


(global-set-key (kbd "<PageUp>") 'xah-beginning-of-line-or-block) ; page up key
(global-set-key (kbd "<PageDown>") 'xah-end-of-line-or-block) ; page down key

;; (global-set-key (kbd "<home>") 'xah-backward-left-bracket)
;; (global-set-key (kbd "<end>") 'xah-forward-right-bracket)



;;(global-set-key (kbd " '") 'mc/edit-lines)

;; TODO : think this a bit and add a COND.
;; mode specific
(eval-after-load 'go-mode
  '(define-key go-mode-map (kbd "C-j") 'godef-jump)) ; navigating to definition in go-mode

(eval-after-load 'c-mode
  '(define-key go-mode-map (kbd "C-j") 'semantic-ia-fast-jump)) ; navigating to definition in c-mode


(eval-after-load 'auto-complete
  '(define-key ac-mode-map (kbd "M-TAB") 'auto-complete))
(put 'downcase-region 'disabled nil)
;; company mode completion
(eval-after-load 'company-mode
  '(define-key company-mode-map (kbd "M-RET c") 'company-complete-common))

;; SET PATH so LateX works
(getenv "PATH")
(setenv "PATH"
	(concat
	 "/usr/texbin" ":" (getenv "PATH")
	 )
	)
(put 'narrow-to-region 'disabled nil)
