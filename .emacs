(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(completion-on-separator-character t)
 '(custom-enabled-themes (quote (wheatgrass)))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(ns-command-modifier (quote meta))
 '(tab-width 4))
(set-face-attribute 'default nil :font "Ubuntu Mono-12")
(load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

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

;; org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-agenda-files (list "~/Dropbox/todo/todo.org"
							 "~/Dropbox/todo/home.org"
							 "~/Dropbox/todo/work.org"))
(setq org-log-done 'time)
(setq org-log-done 'note)

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
		("marmalade" . "http://marmalade-repo.org/packages/")))

;; Custom functions to replicate Vim's C-o and C-O
;; commands - from http://bastibe.de/my-emacs-customizations.html
(defun vi-open-line-above ()
  "Insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(defun vi-open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(global-set-key (kbd "C-o") 'vi-open-line-below)
(global-set-key (kbd "M-o") 'vi-open-line-above)

