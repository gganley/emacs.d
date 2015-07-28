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

;; Smex init
(global-set-key (kbd "M-x") 'smex)

;; better dired
(global-set-key (kbd "C-c d") 'direx:jump-to-directory)

;; Something broke my C-x C-s
(global-set-key (kbd "C-x C-s") 'save-buffer)

;; Call me an i3 fanboy but this works great for me
(global-set-key (kbd "C-c j") 'windmove-left)
(global-set-key (kbd "C-c k") 'windmove-down)
(global-set-key (kbd "C-c l") 'windmove-up)
(global-set-key (kbd "C-c ;") 'windmove-right)

;; Set it to something sensible
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(set-default-font "Source Code Pro-9")

(setq erc-hide-list '("JOIN" "QUIT" "NICK"))

(smex-initialize)

(load-theme 'zenburn t)
(show-paren-mode t)

(require 'auto-complete-config)
(setq ac-delay 0.0)
(setq ac-quick-help-delay 0.5)
(ac-config-default)

(powerline-default-theme)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(provide 'gganley-config)
