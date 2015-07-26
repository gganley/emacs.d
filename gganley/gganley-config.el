(require 'camcorder)

(setq inhibit-default-init t)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)

(blink-cursor-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(fringe-mode 4)
(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'prog-mode-hook #'smartparens-strict-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)
(global-set-key (kbd "C-x C-s") 'save-buffer)

(set-default-font "Anonymous Pro-8")

(setq erc-hide-list '("JOIN" "QUIT" "NICK"))

(smex-initialize)

(load-theme 'zenburn t)
(show-paren-mode t)

(require 'auto-complete-config)
(setq ac-delay 0.0)
(setq ac-quick-help-delay 0.5)
(ac-config-default)

(powerline-default-theme)
(provide 'gganley-config)
