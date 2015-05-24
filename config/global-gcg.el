(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
    (company-bbdb
     company-nxml
     company-css
     company-eclim
     company-semantic
     company-clang
     company-xcode
     company-ropemacs
     company-cmake
     company-capf
     (company-dabbrev-code company-gtags company-etags company-keywords)
     company-oddmuse
     company-files
     company-dabbrev
     company-gtags
     company-ghc)))
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4"
     default)))
 '(inhibit-default-init t)
 '(inhibit-startup-screen t))

;editor and editing
(blink-cursor-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(fringe-mode 4)
(fset 'yes-or-no-p 'y-or-n-p)

					; edititing

(require 'paredit)
(require 'rainbow-delimiters)

(autoload 'enable-paredit-mode "paredit" "asdf" t)
(add-hook 'prog-mode-hook 'enable-paredit-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(global-set-key (kbd "C-x C-S") 'write-file)

; (set-frame-font "Anonymous Pro-12" nil t)
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
(provide 'global-gcg)
