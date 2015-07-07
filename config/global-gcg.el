(setq inhibit-default-init t)
(setq inhibit-startup-screen t)

(blink-cursor-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(fringe-mode 4)
(fset 'yes-or-no-p 'y-or-n-p)

(autoload 'enable-paredit-mode "paredit" "asdf" t)
(add-hook 'prog-mode-hook 'enable-paredit-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(global-set-key (kbd "C-x C-S") 'write-file)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)

(set-frame-font "Anonymous Pro-8" nil t)
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(smex-initialize)

(load-theme 'zenburn t)
(show-paren-mode t)
(add-hook 'emacs-list-mode-hook 'projectile-mode)
(provide 'global-gcg)
