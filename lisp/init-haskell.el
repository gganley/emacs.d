(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
(custom-set-variables '(haskell-tags-on-save t))

(use-package haskell-mode
  :ensure t
  :bind (("C-c C-l" . haskell-process-load-or-reload)
         ("C-c C-z" . haskell-interactive-switch)
         ("C-c C-n C-t" . haskell-process-do-type)
         ("C-c C-n C-i" . haskell-process-do-info)
         ("C-c C-n c" . haskell-process-cabal)
         ("C-c h" . hoogle)
         :map haskell-cabal-mode-map
         ("C-c C-z" . haskell-interactive-switch)
         ("C-c C-k" . haskell-interactive-mode-clear)
         ("C-c C-c" . haskell-process-cabal-build)
         ("C-c c" . haskell-process-cabal))
  :init
  (autoload 'ghc-init "ghc" nil t)
  (autoload 'ghc-debug "ghc" nil t)
  (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode))

(use-package hident
  :ensure t
  :init
  (add-hook 'haskell-mode-hook #'hindent-mode)
  )

(add-to-list 'company-backends 'company-ghc)
(custom-set-variables '(company-ghc-show-info t))

(provide 'init-haskell)
