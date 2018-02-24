;; Git manager
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch))
  :config
  (setq-default magit-diff-refine-hunk t))

(use-package fullframe
  :ensure t
  :init
  (fullframe magit-status magit-mode-quit-window))

(use-package projectile
  :ensure t
  :bind ("s-p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

(provide 'init-project)
