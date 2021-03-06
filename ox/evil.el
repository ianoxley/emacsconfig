;; evil mode customisations, etc.

(require 'evil)
(evil-mode 1)

;; Let <Esc> trigger Emacs C-G
;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;; relative line numbers
(unless (package-installed-p 'relative-line-numbers)
  (package-install 'relative-line-numbers))

;; evil leader mappings
(unless (package-installed-p 'evil-leader)
  (package-install 'evil-leader))
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key "e" 'eval-last-sexp)
(evil-leader/set-key "t" 'org-todo)

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

(unless (package-installed-p 'evil-surround)
  (package-install 'evil-surround))
(require 'evil-surround)
(global-evil-surround-mode 1)

(unless (package-installed-p 'ace-jump-mode)
  (package-install 'ace-jump-mode))
(require 'ace-jump-mode)
(evil-leader/set-key "c" 'ace-jump-mode)
(evil-leader/set-key "r" 'ace-jump-char-mode)
(evil-leader/set-key "l" 'ace-jump-line-mode)

(add-to-list 'load-path "~/.emacs.d/plugins/evil-org")

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
