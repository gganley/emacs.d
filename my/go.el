(use-package go-mode
  :hook ((go-mode . company-mode))
  :ensure t
  :config
  (use-package company-go
    :requires company
    :bind ("M-TAB" . company-complete)
    :config
    (setq company-tooltip-align-annotations t)))

(provide 'my-go)
