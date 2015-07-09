; sadface.el

(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

; bring in all of my .el files
(require 'packages)
(require 'solarized)
(require 'haskell-gcg)
(require 'global-gcg)
(require 'js-gcg)
(require 'lisp-gcg)
