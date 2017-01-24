(setq gc-cons-threshold 2000000)
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
(require 'company)
(exec-path-from-shell-initialize)
(load-user-file "gganley/config.el")
(load-user-file "gganley/js.el")
(load-user-file "gganley/lisp.el")
(load-user-file "gganley/haskell.el")
(load-user-file "gganley/keybindings.el")
(load-user-file "gganley/hooker.el")
(load-user-file "gganley/python.el")
(load-user-file "gganley/c.el")

(custom-set-faces
 '(org-level-1 ((t (:inherit default :foreground "#cb4b16"))))
 '(org-level-2 ((t (:inherit default :foreground "#808000"))))
 '(org-level-3 ((t (:inherit default :foreground "#859900"))))
 '(org-level-4 ((t (:inherit default :foreground "#b58900"))))
 '(org-level-5 ((t (:inherit default :foreground "#2aa198"))))
 '(org-level-6 ((t (:inherit default :foreground "#859900"))))
 '(org-level-7 ((t (:inherit default :foreground "#dc322f"))))
 '(org-level-8 ((t (:inherit default :foreground "#268bd2")))))
