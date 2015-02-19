;; sx config

(unless (package-installed-p 'let-alist)
  (package-install 'let-alist))

(unless (package-installed-p 'sx)
  (package-install 'sx))

(prefer-coding-system 'utf-8)

(require 'sx-load)
(global-set-key (kbd "C-c x") 'sx-tab-frontpage)
