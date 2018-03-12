(use-package elpy
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :after python
  :commands elpy-enable
  :init (with-eval-after-load 'python
          (elpy-enable)
          (remove-hook 'elpy-modules 'elpy-module-flymake))
  :config
  (setq elpy-modules '(elpy-module-sane-defaults
                       elpy-module-company
                       elpy-module-eldoc
                       elpy-module-highlight-indentation
                       elpy-module-pyvenv
                       elpy-module-yasnippet))
  (add-hook 'python-mode-hook #'company-mode)
  (add-hook 'python-mode-hook #'smartparens-strict-mode)
  (add-hook 'python-mode-hook #'pyenv-mode)
  (setq python-shell-interpreter "python3"))

(provide 'init-python)
