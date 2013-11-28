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

(defun github-create-gist ()
  (interactive)
  (let* ((url-request-method "POST")
		(gist-json )
		(url-request-data
		 (json-encode-alist
		  '(("description" . "")
			("public" . t)
			("files" .
			 (((concat (file-name-base (buffer-file-name))
					   "."
					   (file-name-extension (buffer-file-name))) .
					   (("content" . (current-buffer))))))))))
	(switch-to-buffer (url-retrieve "https://api.github.com/gists" 'princ))))

  
(concat (file-name-base (buffer-file-name))
		"."
	(file-name-extension (buffer-file-name)))


(json-encode '(("one" . 1)
			 ("two" . 2)
			 ("three" .
			  '(("three and a half" . "3.5")
				("three and three quarters" . "3.75")))))
