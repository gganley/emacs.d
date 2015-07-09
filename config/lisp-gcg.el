(require 'cider-repl)
(require 'smartparens)
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'clojure-mode-hook #'eldoc-mode)
(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(setq cider-auto-mode nil)
(setq nrepl-log-messages t)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-tab-command #'indent-for-tab-command)
(setq cider-repl-result-prefix "==> ")

(add-hook 'emacs-list-mode-hook 'projectile-mode)
(add-hook 'cider-mode-hook #'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)

(sp-pair "'" nil :actions :rem)

(provide 'lisp-gcg)
