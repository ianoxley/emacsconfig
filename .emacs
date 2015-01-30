(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(completion-on-separator-character t)
 '(custom-enabled-themes (quote (misterioso)))
 '(global-linum-mode t)
 '(ido-enable-flex-matching t)
 '(inhibit-startup-screen t)
 '(ns-command-modifier (quote meta))
 '(tab-width 4))
(set-face-attribute 'default nil :font "Ubuntu Mono-16")
(electric-pair-mode 1)
(show-paren-mode 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;(add-to-list 'load-path "~/.emacs.d/lisp")

;; Global key mappings
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Add files and sub-directories in ~/.emacs.d/lisp/ to the load-path
(let ((default-directory (concat user-emacs-directory
								 (convert-standard-filename "lisp/"))))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

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
	  '(("gnu" . "http://elpa.gnu.org/packages/")
		("marmalade" . "http://marmalade-repo.org/packages/")
		("melpa" . "http://melpa.milkbox.net/packages/")))

;; Install missing packages
(package-initialize)
(mapc
 (lambda (package)
   (or (package-installed-p package)
	   (package-install package)))
 '(evil yasnippet key-chord js2-mode auto-complete markdown-mode expand-region coffee-mode request))

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
(load "~/emacsconfig/ox/org.el")
(load "~/emacsconfig/ox/evil.el")
(load "~/emacsconfig/ox/javascript.el")
(load "~/emacsconfig/ox/ruby.el")
(load "~/emacsconfig/ox/elfeed.el")
(load "~/emacsconfig/ox/sx.el")
(when (file-exists-p "~/emacsconfig/ox/local.el")
  (load "~/emacsconfig/ox/local.el"))

;; auto-complete mode
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(require 'auto-complete-config)
(ac-config-default)

;; expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; mmm-mode
;; (require 'mmm-mode)
