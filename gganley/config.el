;; Inhibits start screen, starts at scratch buffer
(setq inhibit-default-init t)
(setq inhibit-startup-screen t)

;; disables a bunch of shitty UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; Enables modline features
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; User experience better
(fringe-mode 4)
(fset 'yes-or-no-p 'y-or-n-p)

(set-default-font "Source Code Pro-10")

(setq erc-hide-list '("JOIN" "QUIT" "NICK"))

(smex-initialize)

(show-paren-mode t)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq org-directory "/home/gganley/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

(display-time-mode t)

(load-theme 'zenburn t)

(global-prettify-symbols-mode +1)

(add-to-list 'exec-path "/home/gganley/bin")

(add-hook 'org-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-x C-s")
			   '(lambda ()
			      (interactive)
			      (save-buffer)
			      (org-latex-export-to-pdf)))))
(require 'smartparens-config)
(provide 'gganley-config)
