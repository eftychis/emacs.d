;; duplicate-down
(global-set-key (kbd "M-RET d") 'md/duplicate-down)

;; search ag
(global-set-key (kbd "C-(") (lambda ()
			      (interactive)
			      (let (term dest)
				 (setq term (read-string (format "expression (%s): " (thing-at-point 'word))
					     nil nil (thing-at-point 'word)))
				 (setq dest (read-string (format "directory (%s): " (thing-at-point 'word))
					     nil nil (thing-at-point 'word)))
		(ag term dest))))
(global-set-key (kbd "C-)") (lambda ()
		(interactive 2)
		(projectile-ag)))

;; writeroom-mode-global
(global-set-key (kbd "M-RET r") 'writeroom-mode)
;; mc-edit lines
(global-set-key (kbd "M-RET e") 'mc/edit-lines)
;; (define-key global-key-binding (kbd "<C-'") 'mc-edit-lines)
;; (global-set-key (kbd "C-'") 'mc/mark-next-sexps)
;; (global-set-key (kbd "C-\"") 'mc/mark-next-sexps)
;; Follow File (for imports, includes, input etc).
(global-set-key (kbd "M-RET f") 'find-file-at-point)


(global-set-key (kbd "M-RET >") 'mc/mark-next-like-this)
(global-set-key (kbd "M-RET <") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-RET C->") 'mc/mark-all-like-this)
(global-set-key (kbd "M-RET '") 'mc/edit-lines)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; v2

;; writeroom-mode-global
(global-set-key (kbd "C-c r") 'writeroom-mode)
;; mc-edit lines
(global-set-key (kbd "C-c e") 'mc/edit-lines)
;; (define-key global-key-binding (kbd "<C-'") 'mc-edit-lines)
(global-set-key (kbd "C-c '") 'mc/mark-next-sexps)
(global-set-key (kbd "C-c \"") 'mc/mark-next-sexps)


(global-set-key (kbd "C-c c >") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c c <") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c c C->") 'mc/mark-all-like-this)

;;;;;;;;;;;;
;; swap windows
(global-set-key (kbd "C-c s") 'swap-buffers)
;; duplicate the current line or region
(global-set-key (kbd "C-c d") 'md/duplicate-down)
;;(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

;; search with google
(global-set-key (kbd "C-c g") 'google-this)
;; parenthesis related commands
;;(global-set-key (kbd "") `paren-face) 
