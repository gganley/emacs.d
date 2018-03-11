
(require 'init-lisp)

(use-package clojure-mode
  :ensure t
  :config
  (add-hook 'clojure-mode-hook #'subword-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  ;; Credit to Tianxiang Xiong
  (add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))

  ;; Boot script files
  (add-to-list 'magic-mode-alist '(".* boot" . clojure-mode)))

(use-package cider
  :ensure t
  :init
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'cider-mode-hook (lambda () (clj-refactor-mode 1)))
  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'cider-repl-mode-hook (lambda () (clj-refactor-mode 1)))
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)

  :config
  (setq cider-repl-display-help-banner nil
        cider-save-file-on-load t
        cider-pprint-fn 'pprint
        cider-repl-pop-to-buffer-on-connect 'display-only))

(use-package clj-refactor
  :ensure t
  :diminish
  :bind (("C-c m (" . clojure-convert-collection-to-list)
         ("C-c m [" . clojure-convert-collection-to-vector)
         ("C-c m {" . clojure-convert-collection-to-map)
         ("C-c m #" . clojure-convert-collection-to-set)
         ("C-c m '" . clojure-convert-collection-to-quoted-list))
  :init
  (add-hook 'clojure-mode-hook (lambda () (clj-refactor-mode 1)))
  (cljr-add-keybindings-with-prefix "C-c m")
  :config
  (setq cljr-warn-on-eval nil))

(provide 'init-clojure)
