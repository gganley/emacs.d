(add-hook 'prog-mode-hook #'smartparens-strict-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'smartparens-strict-mode)
(add-hook 'prog-mode-hook 'electric-pair-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'js-mode-hook
	  (lambda () (flycheck-mode t)))
(add-hook 'js-mode-hook 'js2-minor-mode)

(global-company-mode)

(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)
(add-hook 'cider-repl-mode-hook #'my-clojure-mode-hook)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)

(provide 'hooker)
