;; org.el

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-agenda-files (list "~/Documents/org/todo.org"
							 "~/Documents/org/home.org"
							 "~/Documents/org/work.org"))
(setq org-log-done 'time)
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
'(org-startup-truncated nil)

(setq org-todo-keywords
	  '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)")))
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("@mac" . ?m) ("@lunch" . ?l)))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

;; org mode capture templates
(setq org-capture-templates
	  '(("t" "Todo" entry (file+headline "~/Documents/org/todo.org" "Tasks")
		 "* TODO %?\n %i\n %a")
		("j" "Journal" entry (file+datetree "~/Documents/org/journal.org")
		 "* %?\nEntered on %U\n %i\n %a")
		("b" "Bug Journal" entry (file+datetree "~/Documents/org/bugs.org")
		 "* %?\nEntered on %U\n %i\n %a")
		("q" "Quotes" entry (file+datetree "~/Documents/org/quotes.org")
		 "* %?\nEntered on %U\n %i\n %a")))

;; org mode recapture settings
(setq org-refile-targets (quote ((nil :maxlevel . 9)
								 (org-agenda-files :maxlevel . 9))))

;; org mode hooks
(add-hook 'org-capture-mode-hook #'visual-line-mode)

;; org-pomodoro
(unless (package-installed-p 'org-pomodoro)
  (package-install 'org-pomodoro))
(global-set-key (kbd "C-c p") 'org-pomodoro)
