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

(require 'benchmark-init)

(require 'auto-complete-config)
(ac-config-default)
(require 'go-autocomplete)
(require 'auto-complete)
(global-auto-complete-mode t)
(package-initialize)

(require 'auto-complete-config)
(ac-config-default)
;; Setup Icicles
(require 'icicles)
(icy-mode t)

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
    ("f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c" "a800120841da457aa2f86b98fb9fd8df8ba682cebde033d7dbf8077c1b7d677a" "d44939ef462b7efb9bb5739f2dd50b03ac9ecf98c4df6578edcf145d6a2d188d" "c0dd5017b9f1928f1f337110c2da10a20f76da0a5b14bb1fec0f243c4eb224d4" "7dd0db710296c4cec57c39068bfffa63861bf919fb6be1971012ca42346a417f" "49ad7c8d458074db7392f8b8a49235496e9228eb2fa6d3ca3a7aa9d23454efc6" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "a041a61c0387c57bb65150f002862ebcfe41135a3e3425268de24200b82d6ec9" default)))
 '(package-selected-packages
   (quote
    (pomodoro redtick tomatinho gscholar-bibtex gtags gtk-pomodoro-indicator eagle-eye wrap-region writegood-mode wolfram xkcd function-args irony rtags benchmark-init cff guru-mode package-build shut-up git commander pallet wgrep sx ace-jump-mode alert async auctex avy biblio-core bind-key color-theme company concurrent connection ctable dash deferred diminish direx edit-at-point epic epl f find-file-in-project flycheck gh ghc git-commit gntp go-eldoc go-mode go-rename haskell-mode header2 helm-bibtex helm-core helm-swoop highlight-indentation ht html-to-markdown htmlize http-post-simple hydra key-chord let-alist lib-requires link log4e logito magit-popup markdown-mode marshal math-symbol-lists multiple-cursors noflet org org-mac-link parsebib pcache pkg-info popup pos-tip pyvenv request seq swiper visual-fill-column with-editor yaoddmuse yasnippet magit-rockstar org-magit auto-complete latex-extra latex-pretty-symbols opener go-guru rpn-calc s s-buffer showkey biblio helm magit projectile z3-mode x-dict writeroom-mode window-numbering window-layout warm-night-theme use-package textmate synosaurus synonyms synonymous switch-window swap-buffers sublimity smooth-scrolling smex smartparens sage-shell-mode ruby-tools rspec-mode python-environment projectile-speedbar outline-magic orglue org-ref org-readme org-projectile org-pomodoro move-dup monokai-theme mc-jump mc-extras magit-gh-pulls latex-unicode-math-mode latex-preview-pane latex-math-preview jazz-theme ivy isearch-symbol-at-point isearch+ intero iedit idomenu ido-at-point icicles ibuffer-git highlight-chars helm-make helm-ispell helm-hoogle helm-gtags helm-c-yasnippet ham-mode hackernews gotest google-translate google-this google golint god-mode go-projectile go-dlv go-direx go-complete go-autocomplete gitty git-blame ggtags fm flyspell-popup flyspell-correct flycheck-perl6 flycheck-haskell flycheck-ghcmod flycheck-color-mode-line flycheck-cask epc eno elscreen elpy eldoro ecb dictionary cpputils-cmake counsel company-math company-go company-ghci company-ghc company-cmake company-cabal company-c-headers company-auctex colorsarenice-theme color-theme-twilight color-theme-tango color-theme-monokai cdlatex auto-complete-auctex ag ace-link ace-jump-zap ace-isearch ace-flyspell ac-python ac-math ac-ispell ac-html ac-helm ac-haskell-process ac-etags ac-emoji ac-clang ac-c-headers)))
 '(rainbow-identifiers-cie-l*a*b*-lightness 30)
 '(rainbow-identifiers-cie-l*a*b*-saturation 35))
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
;; my shortcuts
(global-set-key (kbd "M-[") 'delete-other-windows) ; expand current pane
(global-set-key (kbd "M-]") 'split-window-horizontally) ; split pane top/bottom
(global-set-key (kbd "M-p") 'delete-window) ; close current pane
(global-set-key (kbd "M-s") 'other-window) ; cursorag to other pane
(global-set-key (kbd "M-x") 'smex) ; cursorag to other pane
(global-set-key (kbd "M-g") 'goto-line)        ;
;;(global-set-key (kbd "M-M-c") 'calendar)        
(global-set-key (kbd "M-RET g g") 'god-mode)        ;
(global-set-key (kbd "C-_") 'god-mode)        ;
;; set winner mode
(global-set-key (kbd "C-c <right>") 'winner-redo)
(global-set-key (kbd "C-c <left>") 'winner-undo) 
;; You know, like Readline.
(global-set-key (kbd "M-RET b") 'backward-kill-word)
(global-set-key (kbd "M-RET m p") 'smartparens-mode)
(global-set-key (kbd "M-RET r") 'global-writeroom-mode)

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
