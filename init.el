;;; package -- Summary: initalization
;;; Code
(require 'package)
(put 'set-goal-column 'disabled nil)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
;;
(setq sage-shell:sage-root "/Applications/Sage-6.5.app/Contents/MacOS/Sage")

(require 'cask "~/.emacs.d/.cask/27.1/elpa/cask-20200822.1015/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)
(require 'color)
;; (require 'benchmark-init)

(exec-path-from-shell-initialize)

(require 'auto-complete-config)

(require 'go-autocomplete)
(require 'auto-complete)
(global-auto-complete-mode t)
(package-initialize)
(auto-complete-mode t)

;; Setup Icicles
;; (require 'icicles)
;; (icy-mode t)
(require 'god-mode)
(require 'smartparens)
(require 'smartparens-config)
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


(org-babel-load-file (expand-file-name "rust.org" user-emacs-directory))

(require 'direnv)

(package-install 'intero)
;; load files
(load-file (expand-file-name "extra-buffer-functions.el" user-emacs-directory))
(load-file (expand-file-name "tla-mode.el" user-emacs-directory))
(load-file (expand-file-name "cheat-sh.el" user-emacs-directory))
(load-file (expand-file-name "britanize.el" user-emacs-directory))
(load-file (expand-file-name "latex-utils.el" user-emacs-directory))
;;
(add-to-list 'load-path  (expand-file-name "hsearch-mode.el" user-emacs-directory))
;; browse in emacs
(add-to-list 'load-path  (expand-file-name "eww-custom.el" user-emacs-directory))
;; (add-to-list 'load-path  (expand-file-name "xwidget-custom.el" user-emacs-directory))

;; completion popup is a bit slow: tuning the delay down a notch
(setq company-idle-delay 0.3)
;(setq company-tooltip-align-annotations t)
;; functions - TODO : move them somewhere seperately.
(defun my:ac-c-init()
;;
"Setup autocomplete c mode."
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  ;; running gcc -xc++ -E -v -
  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include")
  )
(add-to-list 'ac-modes 'rust-mode)
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





;;;
;; auto-complete setup, sequence is important
(add-to-list 'ac-modes 'latex-mode) ; beware of using 'LaTeX-mode instead
(add-to-list 'ac-modes 'LaTeX-mode) ; beware of using 'LaTeX-mode instead
(require 'ac-math) ; package should be installed first
(defun my-ac-latex-mode () ; add ac-sources for latex
   (setq ac-sources
         (append '(ac-source-math-unicode
           ac-source-math-latex
           ac-source-latex-commands)
                 ac-sources)))
(add-hook 'LaTeX-mode-hook 'my-ac-latex-mode)
(setq ac-math-unicode-in-math-p t)
(ac-flyspell-workaround) ; fixes a known bug of delay due to flyspell (if it is there)
(add-to-list 'ac-modes 'org-mode) ; auto-complete for org-mode (optional)



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
(org-babel-load-file (expand-file-name "tex.org" user-emacs-directory))

;; symbols
(require 'magic-latex-buffer)
(add-hook 'LaTex-mode-hook 'magic-latex-buffer)

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
;;
;;(add-hook 'haskell-mode-hook #'my-haskell-brittany-mode-hook)

;;(define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def)
(setq haskell-tags-on-save t)
(setq tags-revert-without-query t)
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


;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-to-list 'completion-ignored-extensions ".hi")
;(speedbar-add-supported-extension ".hs")
;(add-hook 'rust-mode-hook #'racer-mode)

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
	 (setq reftex-default-bibliography '("bib.bib" "../bib.bib")); So that RefTeX in Org-mode knows bibliography
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

(setq TeX-parse-self t)


;; Inline pretty symbols
(require 'latex-pretty-symbols)

;; imenu hook for reftex
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)


;; [attempt] sync doc with tex source
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)


;; enable flyspell in rust mode and tex mode.
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'rust-mode-hook 'flyspell-mode)


;; variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(monokai))
 '(custom-safe-themes
   '("d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279" "f9aede508e587fe21bcfc0a85e1ec7d27312d9587e686a6f5afdbb0d220eab50" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9"))
 '(direnv-mode t nil (direnv))
 '(electric-indent-mode nil)
 '(latex-preview-pane-multifile-mode 'off)
 '(org-agenda-files
   '("~/.emacs.d/org-mod.org" "/Users/eftychis/TODO/2Read.org" "/Users/eftychis/TODO/Saturday.org" "/Users/eftychis/TODO/_Problems.org" "~/TODO/Friday"))
 '(org-modules
   '(org-bbdb org-bibtex org-docview org-eww org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m org-annotate-file org-learn org-toc))
 '(package-selected-packages
   '(org-noter-pdftools org-pdftools lsp-grammarly websocket f3 fabric racer org-roam org-roam-server poetry org-d20 fzf rust-auto-use swift-mode lsp-javascript-typescript lsp-typescript tide ts-comint bibliothek org-lookup-dnd company-tabnine forge github-review lsp-dart eglot ac-rtags flymake-rust crux adoc-mode plantuml-mode magithub company-lsp helm-lsp lsp-rust lsp-treemacs lsp-ui ac-racer company-racer helm-rg shm helm-dash tldr emamux projectile-ripgrep rg helm-projectile helm-org-rifle ob-ipython ob-rust toc-org highlight-indent-guides projectile-direnv circe expand-region magic-latex-buffer nixos-options direnv zones avy-flycheck avy-menu nix-update vimish-fold voca-builder intero flycheck-haskell org-brain org-bullets org-clock-convenience org-clock-today nix-buffer nix-mode nix-sandbox helm-hayoo matlab-mode ace-mc smart-cursor-color hi2 helm-ag-r helm-ag hindent projectile-codesearch hayoo dante pomodoro redtick tomatinho gscholar-bibtex gtags gtk-pomodoro-indicator eagle-eye wrap-region writegood-mode wolfram xkcd function-args irony benchmark-init cff guru-mode shut-up git commander pallet wgrep sx ace-jump-mode alert async auctex avy biblio-core color-theme company concurrent connection ctable dash deferred diminish direx edit-at-point epic epl f gh ghc gntp go-eldoc go-mode go-rename header2 helm-bibtex helm-swoop highlight-indentation ht html-to-markdown htmlize http-post-simple key-chord let-alist lib-requires link log4e logito magit-popup marshal math-symbol-lists noflet org org-mac-link parsebib pcache pkg-info popup pos-tip request seq visual-fill-column yaoddmuse yasnippet magit-rockstar org-magit auto-complete latex-extra latex-pretty-symbols opener go-guru rpn-calc s s-buffer showkey biblio projectile z3-mode x-dict writeroom-mode window-numbering window-layout warm-night-theme use-package textmate synosaurus synonyms synonymous switch-window swap-buffers sublimity smooth-scrolling smex sage-shell-mode ruby-tools rspec-mode python-environment projectile-speedbar outline-magic orglue org-readme org-projectile org-pomodoro move-dup monokai-theme mc-jump magit-gh-pulls latex-unicode-math-mode latex-preview-pane latex-math-preview jazz-theme isearch-symbol-at-point isearch+ idomenu ido-at-point icicles ibuffer-git highlight-chars helm-make helm-ispell helm-hoogle helm-gtags helm-c-yasnippet ham-mode gotest google-this google golint god-mode go-projectile go-dlv go-direx go-complete go-autocomplete gitty git-blame ggtags fm flyspell-popup flycheck-perl6 flycheck-ghcmod flycheck-color-mode-line flycheck-cask epc eno elscreen eldoro ecb dictionary cpputils-cmake company-math company-go company-ghci company-ghc company-cmake company-cabal company-c-headers company-auctex colorsarenice-theme color-theme-twilight color-theme-tango color-theme-monokai cdlatex auto-complete-auctex ag ace-link ace-jump-zap ace-isearch ace-flyspell ac-python ac-math ac-ispell ac-html ac-helm ac-haskell-process ac-etags ac-emoji ac-clang ac-c-headers))
 '(rainbow-identifiers-cie-l*a*b*-lightness 30)
 '(rainbow-identifiers-cie-l*a*b*-saturation 35)
 '(safe-local-variable-values
   '((TeX-master . pitch\.tex)
     (TeX-master . \.\./pitch\.tex)
     (reftex-default-ibliography "../bib.bib")
     (reftex-default-bibliography "bib.bib"))))
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
(define-key global-map (kbd "M-j") 'avy-goto-word-or-subword-1)

(put 'upcase-region 'disabled nil)
(window-numbering-mode t)
;; ORG mode configuration
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; Setting org-mode's calendar source files.
(setq org-log-done t)
(setq org-agenda-files `("~/TODO/" "~/TODO/Friday"))
;; (setq org-agenda-files (list "~/WriteUps/todo.org"
;; 			     "~/WriteUps/personal/mytodos.org"
;; 			     "~/WriteUps/personal/today.org"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(ac-flyspell-workaround)
;; latex vars
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;; no exempt buffers for god mode
;;(setq god-exempt-major-modes nil)
(setq god-exempt-predicates nil)
(add-to-list 'god-exempt-major-modes 'latex-preview-pane-mode)
(add-to-list 'god-exempt-major-modes 'magit-modes)
(add-to-list 'god-exempt-major-modes 'dired-mode)
(add-to-list 'god-exempt-major-modes 'pdf-view-mode)


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


(require 'god-mode-isearch)
(define-key isearch-mode-map (kbd "<Meta>") 'god-mode-isearch-activate)
(define-key god-mode-isearch-map (kbd "<Meta>") 'god-mode-isearch-disable)


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
(global-set-key (kbd "C--") 'god-mode-all)
;; load our custom short keybinds
(load-file (expand-file-name "customshortkeys.el" user-emacs-directory))

;;(global-set-key (kbd "M-n") 'god-mode-all)

;;(global-set-key [(shift right)] 'god-mode-all)
(define-key god-local-mode-map (kbd ".") 'repeat)
;; ', "
;; set winner mode
(global-set-key (kbd "C-c <right>") 'winner-redo)
(global-set-key (kbd "C-c <left>") 'winner-undo)
;; You know, like Readline.
;;(global-set-key (kbd "M-RET m p") 'smartparens-mode)
;;(global-set-key (kbd "M-RET r") 'global-writeroom-mode)

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)
;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-i") 'ido-imenu)
;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
;; Fetch the contents at a URL, display it raw.
(global-set-key (kbd "C-x C-h") 'url-view-url)

;; Help should search more than just commands
(global-set-key (kbd "C-h a") 'apropos)

;; Should be able to eval-and-replace anywhere.
;; (global-set-key (kbd "C-c e") 'eval-and-replace)

;; Magit rules!
(global-set-key (kbd "M-RET g s") 'magit-status)
(global-set-key (kbd "M-RET g m p") 'magit-dispatch-popup)
(global-set-key (kbd "M-RET g m s") 'magit-stage)
;;
;; transpose rules
(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(global-set-key [(meta up)] 'transpose-line-up)
(global-set-key [(meta down)] 'transpose-line-down)

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


;;(global-set-key (kbd "<C-c left>") 'xah-beginning-of-line-or-block) ; page up key
;;(global-set-key (kbd "<C-c right>") 'xah-end-of-line-or-block) ; page down key
(global-set-key (kbd "<C-c m p>") 'xah-forward-block) ; page down key
(global-set-key (kbd "<C-c m n>") 'xah-backward-block) ; page down key

;; (global-set-key (kbd "<home>") 'xah-backward-left-bracket)
;; (global-set-key (kbd "<end>") 'xah-forward-right-bracket)

(setq pending-delete-mode nil)

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
;;(eval-after-load 'company-mode
;;  '
(define-key company-mode-map (kbd "TAB") 'company-indent-or-complete-common)
;;)

;; SET PATH so LateX works
(getenv "PATH")
(setenv "PATH"
	(concat
	 "/usr/texbin" ":" (getenv "PATH")
	 )
	)
(put 'narrow-to-region 'disabled nil)
(put 'magit-diff-edit-hunk-commit 'disabled nil)

(org-babel-load-file (expand-file-name "tabnine.org" user-emacs-directory))

;; Setup indentation
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'fill)

(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "org-mod.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "custom-functionality.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "lsp.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "gui.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "misc-modes.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "post-save-hooks.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "org-roam.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "ansi-term.org" user-emacs-directory))


;; I know...
(org-babel-load-file (expand-file-name "typescript.org" user-emacs-directory))




;; save last session
(desktop-save-mode t)
(setq desktop-dirname "~/.emacs.d/desktop/")

;; We turn ac config on after every configuration.
(require 'auto-complete-config) ; should be after add-to-list 'ac-modes and hooks
(ac-config-default)
(setq ac-auto-start t)            ; if t starts ac at startup automatically
(setq ac-auto-show-menu t)
(global-auto-complete-mode t)
;;;
;; init ends here
