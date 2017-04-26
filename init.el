
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit default :foreground "#cb4b16"))))
 '(org-level-2 ((t (:inherit default :foreground "#808000"))))
 '(org-level-3 ((t (:inherit default :foreground "#859900"))))
 '(org-level-4 ((t (:inherit default :foreground "#b58900"))))
 '(org-level-5 ((t (:inherit default :foreground "#2aa198"))))
 '(org-level-6 ((t (:inherit default :foreground "#859900"))))
 '(org-level-7 ((t (:inherit default :foreground "#dc322f"))))
 '(org-level-8 ((t (:inherit default :foreground "#268bd2")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(package-selected-packages
   (quote
    (js2-mode js-comint nodejs-repl tern js3-mode yaml-mode jedi zenburn-theme zenburn wolfram which-key solarized-theme smex smartparens rainbow-mode rainbow-delimiters projectile pdf-tools magit kooten-theme irony haskell-mode flycheck exec-path-from-shell ein company-jedi clj-refactor))))
