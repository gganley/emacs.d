(add-hook 'prog-mode-hook #'smartparens-strict-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'smartparens-strict-mode)
(add-hook 'prog-mode-hook 'electric-pair-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'js-mode-hook
	  (lambda () (flycheck-mode t)))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-ghc)
(provide 'hooker)
