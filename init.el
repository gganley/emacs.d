(menu-bar-mode -1)
(tool-bar-mode -1)
(require 'cl)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(defvar gcg/packages
  '(haskell-mode
    rainbow-delimiters
    paredit
    auto-complete
    smartparens
    smex
    flycheck
    magit
    solarized-theme
    volatile-highlights
    ac-haskell-process))

(defun packages-installed-p ()
  (every #'package-installed-p gcg/packages))
(defun require-package (package)
  (unless (memq package gcg/packages)
    (add-to-list 'gcg/packages package))
  (unless (package-installed-p package)
    (package-install package)))
(defun require-packages (packages)
  (mapc #'require-package packages))
(defun install-packages ()
  (unless (packages-installed-p)
    (package-refresh-contents)
    (require-packages gcg/packages)))
(install-packages)
(defun list-foreign-packages ()
  (interactive)
  (package-show-package-list
   (set-difference package-activated-list gcg/packages)))
(defmacro auto-install (extension package mode)
  `(add-to-list 'auto-mode-alist
                `(,extension . (lambda ()
                                 (unless (package-installed-p ',package)
                                   (package-install ',package))
                                 (,mode)))))
(defvar auto-install-alist
  '(("\\.hs\\'" haskell-mode haskell-mode)
    ("\\.clj\\'" clojure-mode clojure-mode)
    ("\\.css\\'" css-mode css-mode)
    ("\\.html\\'" web-mode web-mode)))
(mapc
 (lambda (entry)
   (let ((extension (car entry))
         (package (cadr entry))
         (mode (cadr (cdr entry))))
     (unless (package-installed-p package)
       (auto-install extension package mode))))
   auto-install-alist)

(require 'solarized)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(haskell-completing-read-function (quote ido-completing-read))
 '(haskell-font-lock-symbols (quote unicode))
 '(haskell-hoogle-command nil)
 '(haskell-mode-hook (quote (turn-on-haskell-doc turn-on-haskell-indentation)))
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(inhibit-default-init t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'smartparens)


(autoload 'smex "smex")
(global-set-key (kbd "M-x") 'smex)

(blink-cursor-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(fringe-mode 4)
(fset 'yes-or-no-p 'y-or-n-p)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)
(smartparens-global-mode +1)
(rainbow-delimiters-mode +1)
(sp-pair "'" nil :actions :rem)

(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq-default ac-expand-on-auto-comlete nil)
(setq-default ac-auto-start nil)
(setq-default ac-dwim nil)

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(add-to-list 'completion-ignored-extensions ".hi")
(add-hook 'interactive-haskell-mode-hook 'ac-haskell-process-setup)
(add-hook 'haskell-interactive-mode-hook 'ac-haskell-process-setup)
(after-load 'haskell-mode
	    (define-key haskell-mode-map (kbd "C-c C-d") 'ac-haskell-process-popup-doc))
(after-load 'auto-complete
	    (add-to-list 'ac-modes 'haskell-interactive-mode)
	    (add-hook 'haskell-interactive-mode-hook 'set-auto-complete-as-completion-at-point-function))
