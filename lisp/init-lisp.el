(use-package rainbow-delimiters
  :ensure t
  :delight)

;; Interactive elisp
(use-package ielm
  :config
  (add-hook 'ielm-mode-hook #'eldoc-mode)
  (add-hook 'ielm-mode-hook #'rainbow-delimiters-mode))

(use-package lisp-mode
  :mode (("Cask" . emacs-lisp-mode))
  :config
  (add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
  (add-hook 'emacs-lisp-mode-hook (lambda () (eros-mode 1)))
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (define-key emacs-lisp-mode-map (kbd "C-c C-c") #'eval-defun)
  (add-hook 'lisp-interaction-mode-hook #'eldoc-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode))

;; TODO: What the fuck does this do
(use-package elisp-slime-nav
  :ensure t
  :diminish
  :config
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook #'elisp-slime-nav-mode)))

(use-package smartparens
  :ensure t
  :diminish
  :bind
  (("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)
   ("C-M-e" . sp-up-sexp)
   ("C-M-d" . sp-down-sexp)
   ("C-M-n" . sp-next-sexp)
   ("C-M-p" . sp-previous-sexp)
   ("C-M-t" . sp-transpose-sexp)
   ("M-D" . sp-splice-sexp)
   ("C-M-k" . sp-kill-sexp)
   ("C-M-w" . sp-copy-sexp)
   ("C-)" . sp-forward-slurp-sexp)
   ("C-M-)" . sp-forward-barf-sexp)
   ("C-M-r" . sp-raise-sexp))
  :init
  (add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
  (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
  (add-hook 'cider-mode-hook #'smartparens-strict-mode)
  (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
  (add-hook 'lisp-interactive-mode-hook #'smartparens-strict-mode)
  :config
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "'" nil :actions nil))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "`" nil :actions nil))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "(" nil :wrap "C-("))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "\"" nil :wrap "C-\""))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "[" nil :wrap "<C-[>"))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "#{" "}" :wrap "C-#"))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "{" nil :wrap "C-{"))
  (sp-with-modes '(org-mode)
    (sp-local-pair "~" nil :wrap "C-~")))

(use-package paren
  :config
  (show-paren-mode +1))

(use-package eldoc
  :diminish)

;; Get some suggestions
(use-package suggest
  :ensure t)

(use-package aggressive-indent
  :ensure t
  :diminish
  :config
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'clojure-mode-hook #'aggressive-indent-mode)
  (add-hook 'cider-mode-hook #'aggressive-indent-mode)
  (add-hook 'cider-repl-mode-hook #'aggressive-indent-mode))

(provide 'init-lisp)
