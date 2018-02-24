(defun doom|init-theme ()
  "Set the theme and load the font, in that order."
  (load-theme 'doom-one t)
  (add-hook 'after-make-frame-functions #'doom|init-theme-in-frame))

(defun doom|init-theme-in-frame (frame)
  "Reloads the theme in new daemon or tty frames."
  (when (or (daemonp) (not (display-graphic-p)))
    (with-selected-frame frame
      (doom|init-theme))))

(use-package doom-themes
  :ensure t
  :init
  (setq doom-themes-enable-bold nil
        doom-themes-enable-italic nil)
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (use-package all-the-icons :ensure t)
  (doom-themes-neotree-config)
  (doom-themes-org-config)
  (add-hook 'emacs-startup-hook #'doom|init-theme)
  )

(provide 'init-themes)
