(require 'cider-repl)
(require 'smartparens)

(add-hook 'clojure-mode-hook #'eldoc-mode)
(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(setq cider-repl-tab-command #'indent-for-tab-command)

(add-hook 'emacs-list-mode-hook 'projectile-mode)
(add-hook 'cider-mode-hook #'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)

(sp-pair "'" nil :actions :rem)

(provide 'gganley-lisp)
