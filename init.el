;; ; sadface.el

;; (add-to-list 'load-path (expand-file-name "gganley" user-emacs-directory))
;; (add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; ; bring in all of my .el files

;; (require 'gganley-packages)
;; (require 'gganley-haskell)
;; (require 'gganley-config)
;; (require 'gganley-haskell)
;; (require 'gganley-js)
;; (require 'gganley-lisp)
(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))


(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "themes/zenburn-theme.el")
(load-user-file "gganley/packages.el")
(load-user-file "gganley/config.el")
(load-user-file "gganley/js.el")
(load-user-file "gganley/lisp.el")
(load-user-file "gganley/haskell.el")
