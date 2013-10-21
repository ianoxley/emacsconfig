;; javascript.el

(require 'js2-mode)

(defun js2-execute-buffer ()
  (interactive)
  (shell-command (concat "node " (buffer-file-name))))

(defun js2-toggle-indent ()
  (interactive)
  (if (= js2-indent-level 2)
	(setq js2-indent-level 4)
	(setq js2-indent-level 4)
	(setq js2-basic-offset 4)
  (setq js2-indent-level 2)
  (setq js2-indent-level 2)
  (setq js2-basic-offset 2))
  
  (message (concat "js-indent-level set to " (number-to-string js2-indent-level))))
