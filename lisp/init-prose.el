(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multi-markdown"
              markdown-hide-urls t)
  :config
  (add-hook 'markdown-mode-hook #'visual-line-mode))
