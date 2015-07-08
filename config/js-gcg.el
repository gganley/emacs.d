(require 'js)
(add-hook 'js-mode-hook 'js2-minor-mode)
(define-key js-mode-map "{" 'paredit-open-curly)
(define-key js-mode-map "}" 'paredit-close-curly-and-newline)
(add-hook 'js-mode-hook
	  (lambda () (flycheck-mode t)))
(provide 'js-gcg)

