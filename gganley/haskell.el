(require 'haskell-mode)
(require 'haskell-cabal)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'flymake-haskell-multi-load)

(define-key haskell-mode-map [f5] 'haskell-process-load-or-reload)
(define-key haskell-mode-map [f8] 'haskell-navigate-imports)
(define-key haskell-mode-map [f9] 'haskell-interactive-mode-visit-error)
(define-key haskell-mode-map [f11] 'haskell-process-cabal-build)
(define-key haskell-mode-map [f12] 'haskell-process-cabal-build-and-restart)
(define-key haskell-mode-map (kbd "C-;") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-mode-show-type-at)
(define-key haskell-mode-map (kbd "C-c C-v") 'haskell-interactive-toggle-print-mode)

(define-key haskell-cabal-mode-map [f9] 'haskell-interactive-mode-visit-error)
(define-key haskell-cabal-mode-map [f11] 'haskell-process-cabal-build)
(define-key haskell-cabal-mode-map [f12] 'haskell-process-cabal-build-and-restart)
(define-key haskell-cabal-mode-map (kbd "C-;") 'haskell-interactive-bring)
(define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)

(provide 'gganley-haskell)
