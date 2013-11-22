;; misc.el

(require 'json)
(require 'request)

(unless (package-installed-p 'request)
  (package-install 'request))

(defun github-status ()
  (request "http://localhost:8000/status.json";; "https://status.github.com/api/status.json"
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
