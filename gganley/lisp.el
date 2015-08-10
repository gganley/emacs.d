(require 'smartparens)
(add-hook 'prog-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(define-key smartparens-mode-map (kbd ")") 'sp-up-sexp)

(sp-pair "'" nil :actions :rem)
(sp-pair "`" nil :actions :rem)
(provide 'gganley-lisp)
