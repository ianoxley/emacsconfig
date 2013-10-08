;; javascript.el

(defun js2-execute-buffer ()
  (interactive)
  (shell-command (concat "node " (buffer-file-name))))

(defun js2-toggle-indent ()
	(if (= js2-indent-level 2)
		(setq js2-indent-level 4)
	  (setq js2-indent-level 2))

	(message (concat "js-indent-level is " (number-to-string js2-indent-level))))
