(require 'js)

(define-key js-mode-map "{" 'paredit-open-curly)
(define-key js-mode-map "}" 'paredit-close-curly-and-newline)

(add-hook 'js-mode-hook
	  (lambda () (flycheck-mode t)))
(add-hook 'js-mode-hook 'js2-minor-mode)

(provide 'gganley-js)
<<<<<<< HEAD:gganley/js.el
=======

>>>>>>> f5952e8bdfb285ec804f4d69abcde57f67be7a2a:gganley/gganley-js.el
