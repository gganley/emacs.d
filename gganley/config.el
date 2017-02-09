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

(set-default-font "Deja Vu Sans Mono-10")
(setq default-frame-alist '((font . "Deja Vu Sans Mono-10")))

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

(global-prettify-symbols-mode +1)

(add-to-list 'exec-path "/home/gganley/bin")

(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))

(setq cider-overlays-use-font-lock t)

(setq cider-pprint-fn 'puget)

(projectile-global-mode)

(load-theme 'solarized-dark t)

(setq-default truncate-lines t)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(setq ein:use-auto-complete t)


(setq wolfram-alpha-app-id
      (with-temp-buffer
	(insert-file-contents "~/wolfram-app-id")
	(buffer-string)))
(require 'smartparens)

(provide 'gganley-config)
