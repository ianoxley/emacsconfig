;; org.el
(use-package org
  :config
  (setq org-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org")
  (setq org-agenda-files (list "~/Library/Mobile Documents/com~apple~CloudDocs/org/todo.org"
                                  "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/home.org"
                                  "~/Library/Mobile Documents/com~apple~CloudDocs/org/work.org"
                                  "~/Library/Mobile Documents/com~apple~CloudDocs/org/notes.org"))
  (setq org-archive-location "%s_archive::datetree/*")

  (setq org-log-done 'time)
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)
  '(org-startup-truncated nil)

  (setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELLED(c@)")))
  (setq org-tag-alist '(("work" . ?w) ("home" . ?h) ("diy" . ?d) ("errands" . ?e)))

  (setq org-default-notes-file "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/notes.org")
  (define-key global-map "\C-cc" 'org-capture)

  ;; org mode capture templates
  (setq org-capture-templates
          '(("t" "Todo" entry (file+headline "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/todo.org" "Tasks")
      "* TODO %?\n %i\n %a")
          ("j" "Journal" entry (file+datetree "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/journal.org")
      "* %?\nEntered on %U\n %i\n %a")))

  (setq org-global-properties
        '(("Effort_ALL" .
           "0:15 0:30 0:45 1:00 1:30 2:00 3:00 4:00 5:00 0:00")))
  (setq org-columns-default-format "%40ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM")
  
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb)
  
  (custom-set-variables
    '(org-agenda-show-all-dates t)
    '(org-agenda-skip-deadline-if-done t)
    '(org-agenda-skip-scheduled-if-done t)
    '(org-deadline-warning-days 14)
    '(org-reverse-note-order t)
    ))
;;(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
