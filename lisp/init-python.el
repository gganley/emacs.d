(use-package elpy
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :init
  (with-eval-after-load 'python (elpy-enable))
  (elpy-enable)
  (elpy-company-backend)
  :config
  (add-hook 'python-mode-hook #'company-mode)
  (add-hook 'python-mode-hook #'smartparens-strict-mode)
  (setq python-shell-interpreter "python3")
  )

(provide 'init-python)
