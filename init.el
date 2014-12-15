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
 '(haskell-process-type 'cabal-repl)
 '(haskell-process-args-cabal-repl
   '("--ghc-option=ferror-spans" "--with-ghc=ghci-ng"))
 '(haskell-notify-p t)
 '(haskell-stylish-on-save nil)
 '(haskell-tags-on-save nil)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-reload-with-fbytecode nil)
 '(haskell-process-use-presentation-mode t)
 '(haskell-interactive-mode-include-file-name nil)
 '(haskell-interactive-mode-eval-pretty nil)
 '(shm-use-presentation-mode t)
 '(shm-auto-insert-skeletons t)
 '(haskell-process-suggest-haskell-docs-imports t)
 '(hindent-style "chris-done")
 '(haskell-interactive-mode-eval-mode 'haskell-mode)
 '(haskell-process-path-ghci "ghci-ng")
 '(haskell-process-args-ghci '("-ferror-spans"))
 '(haskell-process-args-cabal-repl
   '("--ghc-option=-ferror-spans" "--with-ghc=ghci-ng"))
 '(haskell-process-generate-tags nil)
 '(haskell-complete-module-preferred
   '("Data.ByteString"
     "Data.ByteString.Lazy"
     "Data.List"
     "Data.Maybe"
     "Data.Monoid"))
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

(smex-initialize)

;; Haskell
(load "~/.emacs.d/hindent")
(require 'hindent)
(require 'haskell-mode)
(require 'haskell-process)
(require 'haskell-interactive-mode)
(require 'haskell-font-lock)


(defun haskell-process-all-types ()
  (interactive)
  (let ((session (haskell-session)))
    (switch-to-buffer (get-buffer-create (format "*%s:all-types*"
						 (haskell-session-name (haskell-session)))))
    (setq haskell-session session)
    (cd (haskell-session-current-dir session))
    (let ((inhibit-read-only t))
      (erase-buffer)
      (let ((haskell-process-log nil))
	(insert (haskell-process-queue-sync-request (haskell-process) ":all-types")))
      (unless (eq major-mode 'completion-mode)
	(completion-mode)
	(setq compilation-error-regex-alist
	      haskell-compilation-error-regexp-alist)))))
(defun haskell-interactive-toggle-print-mode ()
  (interactive)
  (setq haskell-interactive-mode-eval-mode
	(intern
	 (ido-completing-read "Eval result mode: "
			      '("fundamental-mode"
				"haskell-mode"
				"espresso-mode"
				"ghc-core-mode"
				"org-mode")))))
(defun haskell-insert-doc ()
  (interactive)
  (insert "-- |"))
(defun haskell-move-right ()
  (interactive)
  (haskell-move-nested 1))
(defun haskell-move-left ()
  (interactive)
  (haskell-move-nested -1))
(defun haskell-insert-undefined ()
  (interactive)
  (if (and (boundp 'structured-haskell-mode)
	   structured-haskell-mode)))

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

(set-frame-font "Anonymous Pro-8" nil t)
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
