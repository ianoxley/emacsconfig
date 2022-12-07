(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(completion-on-separator-character t)
 '(custom-enabled-themes '(misterioso))
 '(ido-enable-flex-matching t)
 '(inhibit-startup-screen t)
 '(ns-command-modifier 'meta)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-deadline-warning-days 14)
 '(org-reverse-note-order t)
 '(package-selected-packages
   '(magit rbenv ruby-electric helm-ag helm-projectile company projectile yaml-mode use-package undo-tree js2-mode inf-ruby helm expand-region evil))
 '(tab-width 2))
(set-face-attribute 'default nil :font "Ubuntu Mono-18")
(electric-pair-mode 1)
(show-paren-mode 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Add melpa
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(setq mac-option-modifier 'super)

;;(add-to-list 'load-path "~/.emacs.d/lisp")
(setq-default indent-tabs-mode nil)
(setq web-mode-markup-indent-offset 2)

;; From homebrew install
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
    (normal-top-level-add-subdirs-to-load-path))

;; Global key mappings
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Markdown mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
	  (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; Save auto-save and backup files in the system temp folder
(setq backup-directory-alist
	  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))

;; Steve yegge effective emacs suggestions
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; Fix the hash key on os x
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;; Install missing packages
(package-initialize)
;; (mapc
;; (lambda (package)
;;   (or (package-installed-p package)
;;	   (package-install package)))
;; '(evil yasnippet key-chord js2-mode auto-complete markdown-mode expand-region request magit))

;; ido mode
;; (require 'ido)
;; (ido-mode t)
;; (add-hook 'ido-setup-hook
;; 		  (lambda()
;; 			;; Go straight home
;; 			(define-key ido-file-completion-map
;; 			  (kbd "~")
;; 			  (lambda()
;; 				(interactive)
;; 				(if (looking-back "/")
;; 					(insert "~/")
;; 				  (call-interactively 'self-insert-command))))))

;; package specific stuff
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(use-package use-package
  :config
  (setq use-package-always-ensure t))

(load "~/emacsconfig/ox/org.el")
;; (load "~/emacsconfig/ox/evil.el")
(load "~/emacsconfig/ox/javascript.el")
(load "~/emacsconfig/ox/ruby.el")
;; (load "~/emacsconfig/ox/elfeed.el")
;; (load "~/emacsconfig/ox/sx.el")
;; (load "~/emacsconfig/ox/web-mode.el")
(when (file-exists-p "~/emacsconfig/ox/local.el")
  (load "~/emacsconfig/ox/local.el"))

;; expand region
(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(load "~/emacsconfig/lisp/uuid.el")
(defun uuid-insert()
  (interactive)
  (require 'uuid)
  (insert (upcase (uuid-string))))

(global-set-key (kbd "C-c C-'") 'uuid-insert)

(global-set-key (kbd "C-c w") 'wc-goal-mode)

(defun setup-windows ()
  (interactive)
  (delete-other-windows)

  (sx-tab-frontpage t nil)
  (split-window-horizontally)
  (other-window 1)
  (split-window-vertically)
  (other-window 1)
  (elfeed)
  (elfeed-update)
  ;; (split-window-vertically)
  ;; (org-agenda-list)
  ;; (if (package-installed-p 'twittering-mode)
  ;; 	  (twit)

  (window-configuration-to-register ?w))

(set-frame-parameter nil 'fullscreen 'fullboth)
;; (setup-windows)
;; (find-file "~/Library/Mobile Documents/com~apple~CloudDocs/org/home.org")
(org-agenda-list)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(use-package undo-tree
  :config
  (global-undo-tree-mode)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/.cache"))))

(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1))

(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-project-search-path '("~/dev" "~/play")))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package helm-projectile)
(use-package helm-ag)
(use-package ruby-electric
  :config
  (add-hook 'ruby-hook-mode 'ruby-electric-mode))
(use-package rbenv
  :config
  (global-rbenv-mode)
  (rbenv-use-global))
