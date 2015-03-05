;; misc.el

(require 'json)
(require 'request)

(defun github-status ()
  (interactive)
  (request "https://status.github.com/api/status.json"
		   :parser 'json-read
		   :success (function*
					 (lambda (&key data &allow-other-keys)
					   (message "GitHub status: %s ( as of %s )"
								(assoc-default 'status data)
								(format-time-string "%a %d %b %Y at %T" 
													(date-to-time
													 (assoc-default 'last_updated data))))))
		   :error (function*
				   (lambda (&key error-thrown &allow-other-keys&rest _)
					 (message "Error: %S"
							  error-thrown)))))

(defun buffer-mode (&optional buffer-or-name)
  "Returns the major mode associated with a buffer.
If buffer-or-name is nil return current buffer's mode."
  (buffer-local-value 'major-mode
   (if buffer-or-name (get-buffer buffer-or-name) (current-buffer))))


