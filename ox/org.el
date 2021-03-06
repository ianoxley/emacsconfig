;; org.el
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-directory "~/org")
(setq org-agenda-files (list "~/org/todo.org"
							 "~/org/home.org"
							 "~/org/work.org"
               "~/org/notes.org"))
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
(setq org-mobile-directory "~/Dropbox/apps/MobileOrg")

(setq org-mobile-use-encryption t)
;; password set in local.el

(setq org-log-done 'time)
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
'(org-startup-truncated nil)

(setq org-todo-keywords
	  '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELLED(c@)")))
(setq org-tag-alist '(("work" . ?w) ("home" . ?h) ("diy" . ?d) ("errands" . ?e) ("next" . ?n)))

(setq org-default-notes-file "~/org/notes.org")
(define-key global-map "\C-cc" 'org-capture)

;; org mode capture templates
(setq org-capture-templates
	  '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Inbox")
		 "* TODO %?\n %i\n %a")
		("j" "Journal" entry (file+datetree "~/org/journal.org")
		 "* %?\nEntered on %U\n %i\n %a")
		("l" "Learning Journal" entry (file+datetree "~/org/learning.org")
		 "* %?\nEntered on %U\n %i\n %a")
    ("s" "Senior Competencies" entry (file+datetree "~/org/senior.org"))))

;; org mode recapture settings
(setq org-refile-targets (quote ((nil :maxlevel . 9)
								 (org-agenda-files :maxlevel . 9))))

;; org mode hooks
(add-hook 'org-capture-mode-hook #'visual-line-mode)

;; org-pomodoro
(unless (package-installed-p 'org-pomodoro)
  (package-install 'org-pomodoro))
(global-set-key (kbd "C-c p") 'org-pomodoro)
