(require 'haskell-commands)

(defun my-brittany-auto-format ()
  (interactive)
  ;; (save-restriction
  ;;   (save-excursion
  ;;     (let ((buf (buffer-string))
  ;; 	    write-contents-hooks)
  ;; 	(unless (= 0 (call-process-region (point-min) (point-max)
  ;; 					  "brittany" t t nil "--indent=2"))
  ;; 	  (delete-region (point-min) (point-max))
  ;; 	  (insert buf)
  ;; 	  (set-buffer-modified-p nil)
  ;; 	  (unless (= 0 (call-process-region (point-min) (point-max)
  ;; 					    "stylish-haskell" t t))
  ;; 	    (delete-region (point-min) (point-max))
  ;; 	    (insert buf)
  ;; 	    (set-buffer-modified-p nil))
  ;; 	  )
  ;; 	)

  ;;     )
  ;;  )
  ;; From A. Ramirez
  ;; see https://github.com/haskell/haskell-mode/blob/dd0ea640fa449d021399a17db65e4d50d3f0f2a9/haskell-commands.el#L811
  (haskell-mode-buffer-apply-command "brittany"))

(defun my-haskell-brittany-mode-hook ()
  (haskell-indentation-mode)
  (setq-local normalize-hook '(my-brittany-auto-format))
  (add-hook 'write-contents-hooks
	    #'(lambda ()
		(ignore
		 (whitespace-cleanup)
		 (my-brittany-auto-format))) nil t)
  (interactive-haskell-mode)
  (diminish 'interactive-haskell-mode)
  (flycheck-mode 1)
  (flycheck-haskell-setup)
  (setq-local prettify-symbols-alist haskell-prettify-symbols-alist)
  (prettify-symbols-mode 1)
  (bug-reference-prog-mode 1))
