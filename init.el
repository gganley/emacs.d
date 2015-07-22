; sadface.el

(add-to-list 'load-path (expand-file-name "gganley" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

; bring in all of my .el files
(require 'gganley-packages)
(require 'gganley-haskell)
(require 'gganley-global)
(require 'gganley-js)
(require 'gganley-lisp)
