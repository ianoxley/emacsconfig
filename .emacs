(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(completion-on-separator-character t)
 '(custom-enabled-themes (quote (wheatgrass)))
 '(global-linum-mode t)
 '(ido-enable-flex-matching t)
 '(inhibit-startup-screen t)
 '(ns-command-modifier (quote meta))
 '(tab-width 4))
(set-face-attribute 'default nil :font "Ubuntu Mono-12")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'load-path "~/.emacs.d/")

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
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
'(org-startup-truncated nil)

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

;; org mode capture templates
(setq org-capture-templates
	  '(("t" "Todo" entry (file+headline "~/Dropbox/todo/todo.org" "Tasks")
		 "* TODO %?\n %i\n %a")
		("j" "Journal" entry (file+datetree "~/Dropbox/todo/journal.org")
		 "* %?\nEntered on %U\n %i\n %a")))

;; org mode recapture settings
(setq org-refile-targets (quote ((nil :maxlevel . 9)
								 (org-agenda-files :maxlevel . 9))))

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

;; Install missing packages
(package-initialize)
(mapc
 (lambda (package)
   (or (package-installed-p package)
           (if (y-or-n-p (format "Package %s is missing. Install it? " package))
                   (package-install package))))
 '(evil yasnippet key-chord js2-mode auto-complete markdown-mode expand-region coffee-mode))

;; file types
(add-to-list 'load-path
			 "~/.emacs.d/elpa/yasnippet-20130831.2348")
(require 'yasnippet)
(yas-global-mode 1)

(setq auto-mode-alist (cons '("Rakefile$" . ruby-mode) auto-mode-alist))

;; js2 mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq js-indent-level 2)
(setq js2-indent-level 2)
(setq js2-basic-offset 2)

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

;; org mode hooks
(add-hook 'org-capture-mode-hook #'visual-line-mode)

;; Evil mode
(require 'evil)
(evil-mode 1)

;; 'jk' exits insert mode
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

;; auto-complete mode
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(require 'auto-complete-config)
(ac-config-default)

;; expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; mmm-mode
(require 'mmm-mode)

