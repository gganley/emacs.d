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

(load-user-file "gganley/packages.el")
(load-user-file "gganley/config.el")
(load-user-file "gganley/js.el")
(load-user-file "gganley/lisp.el")
(load-user-file "gganley/haskell.el")
(load-user-file "gganley/keybindings.el")
(load-user-file "gganley/hooker.el")
(load-user-file "gganley/python.el")
(load-user-file "gganley/c.el")
