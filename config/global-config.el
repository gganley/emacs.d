(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-ropemacs company-cmake company-capf
		  (company-dabbrev-code company-gtags company-etags company-keywords)
		  company-oddmuse company-files company-dabbrev company-gtags company-ghc)))
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(haskell-complete-module-preferred
   (quote
    ("Data.ByteString" "Data.ByteString.Lazy" "Data.List" "Data.Maybe" "Data.Monoid")))
 '(haskell-interactive-mode-eval-mode (quote haskell-mode))
 '(haskell-interactive-mode-eval-pretty nil)
 '(haskell-interactive-mode-include-file-name nil)
 '(haskell-notify-p t)
 '(haskell-process-args-cabal-repl (quote ("--ghc-option=-ferror-spans" "--with-ghc=ghci-ng")))
 '(haskell-process-args-ghci (quote ("-ferror-spans")))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-generate-tags nil)
 '(haskell-process-log t)
 '(haskell-process-path-ghci "ghci-ng")
 '(haskell-process-reload-with-fbytecode nil)
 '(haskell-process-suggest-haskell-docs-imports t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-process-use-presentation-mode t)
 '(haskell-stylish-on-save nil)
 '(haskell-tags-on-save nil)
 '(hindent-style "chris-done")
 '(inhibit-default-init t)
 '(inhibit-startup-screen t)
 '(shm-auto-insert-skeletons t)
 '(shm-use-presentation-mode t))
(require 'smartparens)
(smex-initialize)
(provide 'config)
(blink-cursor-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(fringe-mode 4)
(fset 'yes-or-no-p 'y-or-n-p)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)
(smartparens-global-mode t)
(rainbow-delimiters-mode t)
(sp-pair "'" nil :actions :rem)
(set-frame-font "Anonymous Pro-8" nil t)
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
(provide 'global-config)
