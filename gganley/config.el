(setq inhibit-default-init t)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(fringe-mode 4)
(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'prog-mode-hook #'smartparens-strict-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)


(set-default-font "Source Code Pro-9")

(setq erc-hide-list '("JOIN" "QUIT" "NICK"))

(smex-initialize)

(show-paren-mode t)

(setq ac-delay 0.0)
(setq ac-quick-help-delay 0.5)
(ac-config-default)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq org-directory "/home/gcganley/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

(display-time-mode t)

(load-theme 'solarized-dark)
(provide 'gganley-config)
