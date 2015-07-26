; sadface.el

(add-to-list 'load-path (expand-file-name "gganley" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

; bring in all of my .el files
<<<<<<< HEAD
(require 'gganley-packages)
(require 'gganley-haskell)
(require 'gganley-global)
=======

(require 'gganley-packages)
(require 'gganley-config)
(require 'gganley-haskell)
>>>>>>> f5952e8bdfb285ec804f4d69abcde57f67be7a2a
(require 'gganley-js)
(require 'gganley-lisp)
