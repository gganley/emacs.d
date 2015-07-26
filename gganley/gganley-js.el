(require 'js)

(define-key js-mode-map "{" 'paredit-open-curly)
(define-key js-mode-map "}" 'paredit-close-curly-and-newline)

(add-hook 'js-mode-hook
	  (lambda () (flycheck-mode t)))
(add-hook 'js-mode-hook 'js2-minor-mode)

(provide 'gganley-js)

