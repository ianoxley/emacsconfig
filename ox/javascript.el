;; javascript.el

(defun js2-execute-buffer ()
  (interactive)
  (shell-command (concat "node " (buffer-file-name))))
