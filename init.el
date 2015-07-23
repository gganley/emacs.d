; sadface.el

(add-to-list 'load-path (expand-file-name "gganley" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

; bring in all of my .el files
<<<<<<< HEAD
(require 'packages)
(require 'haskell-gcg)
(require 'global-gcg)
(require 'js-gcg)
(require 'lisp-gcg)
=======
(require 'gganley/packages)
(require 'gganley/haskell)
(require 'gganley/global)
(require 'gganley/js)
(require 'gganley/lisp)
>>>>>>> b3ad385813c171a8d85c87920814ccc4237b0736
