;; ruby.el

(use-package inf-ruby)
(use-package yaml-mode)

(setq auto-mode-alist (cons '("Rakefile$" . ruby-mode) auto-mode-alist))
