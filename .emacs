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

;; Add Marmalade package repository
(setq package-archives
	  '(("gnu" . "https://elpa.gnu.org/packages/")
		;;("marmalade" . "https://marmalade-repo.org/packages/")
		("melpa" . "https://melpa.org/packages/")))

;; Install missing packages
(package-initialize)
(mapc
 (lambda (package)
   (or (package-installed-p package)
	   (package-install package)))
 '(evil yasnippet key-chord js2-mode auto-complete markdown-mode expand-region request magit))

;; file types
;; (add-to-list 'load-path
;; 			 "~/.emacs.d/elpa/yasnippet-20130831.2348")
;; (require 'yasnippet)
;; (yas-global-mode 1)

;; ido mode
(require 'ido)
(ido-mode t)
(add-hook 'ido-setup-hook
		  (lambda()
			;; Go straight home
			(define-key ido-file-completion-map
			  (kbd "~")
			  (lambda()
				(interactive)
				(if (looking-back "/")
					(insert "~/")
				  (call-interactively 'self-insert-command))))))

;; package specific stuff
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(use-package use-package
  :config
  (setq use-package-always-ensure t))

(load "~/emacsconfig/ox/org.el")
(load "~/emacsconfig/ox/evil.el")
(load "~/emacsconfig/ox/javascript.el")
(load "~/emacsconfig/ox/ruby.el")
(load "~/emacsconfig/ox/elfeed.el")
(load "~/emacsconfig/ox/sx.el")
(load "~/emacsconfig/ox/web-mode.el")
(when (file-exists-p "~/emacsconfig/ox/local.el")
  (load "~/emacsconfig/ox/local.el"))

(when (boundp 'evil-emacs-state-modes)
  (add-to-list 'evil-emacs-state-modes 'sx-question-list-mode)
  (add-to-list 'evil-emacs-state-modes 'sx-inbox-mode)
  (add-to-list 'evil-emacs-state-modes 'elfeed)
  (add-to-list 'evil-emacs-state-modes 'magit-status))

;; auto-complete mode
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20170124.1845/dict")
(require 'auto-complete-config)
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

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
(org-agenda-list)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(require 'helm-config)
