;; sx config

(unless (package-installed-p 'let-alist)
  (package-install 'let-alist))

(add-to-list 'load-path
			 (convert-standard-filename "~/emacsconfig/lisp/sx"))

(prefer-coding-system 'utf-8)

(require 'sx-load)
(global-set-key (kbd "C-c x") 'sx-tab-frontpage)

(when (boundp 'evil-emacs-state-modes)
  (add-to-list 'evil-emacs-state-modes 'sx-question-list-mode)
  (add-to-list 'evil-emacs-state-modes 'sx-inbox-mode))
