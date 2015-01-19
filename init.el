(menu-bar-mode -1)
(tool-bar-mode -1)
(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

(require 'packages)
(require 'solarized)
(require 'haskell-gcg)
(require 'global-gcg)


(setenv "PATH" (concat "/home/gcganley/.cabal/bin:" (getenv "PATH")))
;;  Hooks
;;; Company
(add-hook 'after-init-hook 'global-company-mode)

;;; Haskell

;;  Key Bindings
;;; Company
(global-set-key (kbd "C-c SPC") 'company-complete)
(global-set-key (kbd "C-x C-s") 'save-buffer)



;;; Haskell
