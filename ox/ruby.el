;; ruby.el

(unless (package-installed-p 'inf-ruby)
  (package-install 'inf-ruby))
(unless (package-installed-p 'rspec-mode)
  (package-install 'rspec-mode))

(eval-after-load 'rspec-mode
  '(rspec-install-snippets))

(setq auto-mode-alist (cons '("Rakefile$" . ruby-mode) auto-mode-alist))
