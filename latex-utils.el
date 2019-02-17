;; attributed to https://stackoverflow.com/questions/10531115/insert-starred-environment-or-command-in-auctex
(defun LaTeX-star-environment-dwim ()
  "Convert between the starred and the not starred version of the current environment."
  (interactive)
  ;; If the current environment is starred.
  (if (string-match "\*$" (LaTeX-current-environment))
      ;; Remove the star from the current environment.
      (LaTeX-modify-environment (substring (LaTeX-current-environment) 0 -1))
    ;; Else add a star to the current environment.
    (LaTeX-modify-environment (concat (LaTeX-current-environment) "*"))))
