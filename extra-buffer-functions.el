(defun copy-buffer ()
  "Copy contents of buffer to clipboard"
  (interactive)
  (clipboard-kill-ring-save (point-min) (point-max)))
