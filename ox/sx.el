;; sx config

(add-to-list 'load-path
			 (convert-standard-filename "~/emacsconfig/lisp/sx"))
(prefer-coding-system 'utf-8)
(require 'sx-load)

(global-set-key (kbd "C-c x") 'sx-tab-frontpage)
