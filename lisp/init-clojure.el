(require 'init-lisp)

(use-package clojure-mode
  :ensure t
  :config
  (add-hook 'clojure-mode-hook #'subword-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode))

(use-package cider
  :ensure t
  :config
  (setq cider-repl-display-help-banner nil)
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode))

(use-package clj-refactor
  :ensure t
  :diminish
  :init
  ;; Taken from weavejester
  (add-hook 'clojure-mode-hook (lambda () (clj-refactor-mode 1)))
  :config
  (cljr-add-keybindings-with-prefix "C-c m"))
