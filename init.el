(menu-bar-mode -1)
(tool-bar-mode -1)
(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))
(require 'packages)
(require 'solarized)
(require 'config)
(require 'haskell-config)
;;  Hooks
;;; Company
(add-hook 'after-init-hook 'global-company-mode)

;;; Haskell

(add-hook 'haskell-mode-hook 'structured-haskell-mode)

;;  Key Bindings
;;; Company
(global-set-key (kbd "C-c SPC") 'company-complete)
;;; Haskell
