;; javascript.el

;; js2 mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq js-indent-level 2)
(setq js2-indent-level 2)
(setq js2-basic-offset 2)

(require 'js2-mode)

(defun js2-execute-buffer ()
  (interactive)
  (shell-command (concat "node " (buffer-file-name))))

(defun js2-toggle-indent ()
  "Toggles the indentation level of JavaScript files between 2 and 4 spaces.
  
  For each of js-indent-level, js2-indent-level, and js2-basic-offset:
  if their value is 2 then its changed to 4; whereas if their value is
  4 its changed to 2."
  (interactive)
  (setq js-indent-level (if (= js-indent-level 2) 4 2))
  (setq js2-indent-level (if (= js-indent-level 2) 4 2))
  (setq js2-basic-offset (if (= js-indent-level 2) 4 2))
  (message "js-indent-level, js2-indent-level, and js2-basic-offset set to %d"
		   js2-basic-offset))

