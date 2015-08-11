;; Smex init
(global-set-key (kbd "M-x") 'smex)

;; better dired
(global-set-key (kbd "C-c d") 'direx:jump-to-directory)

;; Something broke my C-x C-s
(global-set-key (kbd "C-x C-s") 'save-buffer)

;; Call me an i3 fanboy but this works great for me
(global-set-key (kbd "C-c j") 'windmove-left)
(global-set-key (kbd "C-c k") 'windmove-down)
(global-set-key (kbd "C-c l") 'windmove-up)
(global-set-key (kbd "C-c ;") 'windmove-right)

;; Set it to something sensible
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Org shit
(global-set-key (kbd "C-c c") 'org-capture)

;; Magit
(global-set-key (kbd "C-c g") 'magit-status)

;; Smart parens
(global-set-key (kbd "C-)") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-(") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-M-)") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-M-(") 'sp-backward-barf-sexp)

;; Magit
(global-set-key (kbd "C-c g") 'magit-status)

(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]  
             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
  (global-unset-key k))
(define-key js-mode-map "{" 'paredit-open-curly)
(define-key js-mode-map "}" 'paredit-close-curly-and-newline)
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
(define-key smartparens-mode-map (kbd ")") 'sp-up-sexp)


(provide 'keybindings)
