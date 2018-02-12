;;; package --- Summary:

;;; Commentary:

;; -*- lexical-binding: t -*-

;;; Most of this is taken from bbatsov so thanks to him
;;; More of it is taken and I've attempted to keep track

;;; Code:
(setq debug-on-error t)

(require 'package)

(setq is-a-mac (eq system-type 'darwin))

(if is-a-mac
  (set-face-attribute 'default t :font "Monaco-9")
  (set-face-attribute 'default t :font "Source Code Pro-10"))

(setq custom-file "~/.emacs-custom.el")
(load custom-file)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(setq load-prefer-newer t)

(setq gc-cons-threshold 50000000)

(defconst savefile-dir (expand-file-name "savefile" user-emacs-directory))

(defvar flycheck-emacs-lisp-load-path 'inherit)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(blink-cursor-mode -1)

(setq ring-bell-function 'ignore)

(setq inhibit-startup-screen t)

(setq scroll-margin 0
      scroll-conservatively 10000
      scroll-preserve-screen-position 10)

(toggle-scroll-bar -1)

(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

(setq require-final-newline t)

(delete-selection-mode t)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(global-auto-revert-mode t)

(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

(global-set-key (kbd "M-/") #'hippie-expand)
(global-set-key (kbd "s-/") #'hippie-expand)

(global-set-key (kbd "C-x C-b") #'ibuffer)


;; TODO: Lookup this command and wh
(define-key 'help-command (kbd "C-i") #'info-display-manual)



(setq tab-always-indent 'complete)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(define-key input-decode-map [?\C-\[] (kbd "<C-[>"))

(require 'use-package)

(use-package rainbow-delimiters
  :ensure t)

(use-package ielm
  :config
  (add-hook 'ielm-mode-hook #'eldoc-mode)
  (add-hook 'ielm-mode-hook #'rainbow-delimiters-mode))



(use-package lisp-mode
  :config
  (add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (define-key emacs-lisp-mode-map (kbd "C-c C-c") #'eval-defun)
  (add-hook 'lisp-interaction-mode-hook #'eldoc-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode))



(global-hl-line-mode +1)


;; Holy shit this is amazing
(use-package avy
  :ensure t
  :bind (("s-." . avy-goto-word-or-subword-1)
         ("s-," . avy-goto-char))
  :config
  (setq avy-background t))

(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))


(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package projectile
  :ensure t
  :bind ("s-p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

(use-package elisp-slime-nav
  :ensure t
  :config
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook #'elisp-slime-nav-mode)))


(require 'smartparens)
(use-package smartparens
  :ensure t
  :bind
  (("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)
   ("C-M-e" . sp-up-sexp)
   ("C-M-d" . sp-down-sexp)
   ("C-M-n" . sp-next-sexp)
   ("C-M-p" . sp-previous-sexp)
   ("C-M-t" . sp-transpose)
   ("M-D" . sp-splice-sexp)
   ("C-M-k" . sp-kill-sexp)
   ("C-M-w" . sp-copy-sexp)
   ("C-)" . sp-forward-slurp-sexp)
   ("C-M-)" . sp-forward-barf-sexp))
  :config
  (add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
  (add-hook 'lisp-interaction-mode-hook #'smartparens-strict-mode)
  (add-hook 'ielm-mode-hook #'smartparens-strict-mode)
  (add-hook 'lisp-mode-hook #'smartparens-strict-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'smartparens-strict-mode)
  (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
  (add-hook 'cider-mode-hook #'smartparens-strict-mode)
  (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "'" nil :actions nil))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "`" nil :actions nil))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "(" nil
                   :wrap "C-("))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "\"" nil
                   :wrap "C-\""))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "[" nil
                   :wrap "<C-[>"))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "#{" "}"
                   :wrap "C-#"))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "{" nil
                   :wrap "C-{")))

(use-package paren
  :config
  (show-paren-mode +1))

(use-package saveplace
  :config
  (setq save-place-file (expand-file-name "saveplace" savefile-dir))
  ;; activate it for all buffers
  (setq-default save-place t))

(use-package savehist
  :config
  (setq savehist-additional-variables
        ;; search entries
        '(search-ring regexp-search-ring)
        ;; save every minute
        savehist-autosave-interval 60
        ;; keep the home clean
        savehist-file (expand-file-name "savehist" savefile-dir))
  (savehist-mode +1))

(use-package recentf
  :config
  (setq recentf-save-file (expand-file-name "recentf" savefile-dir)
        recentf-max-saved-items 500
        recentf-max-menu-items 15
        ;; disable recentf-cleanup on Emacs start, because it can cause
        ;; problems with remote files
        recentf-auto-cleanup 'never)
  (recentf-mode +1))

(use-package windmove
  :config
  ;; use shift + arrow keys to switch between visible buffers
  (windmove-default-keybindings))

(use-package dired
  :config
  ;; dired - reuse current buffer by pressing 'a'
  (put 'dired-find-alternate-file 'disabled nil)

  ;; always delete and copy recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  ;; if there is a dired buffer displayed in the next window, use its
  ;; current subdir, instead of the current subdir of this dired buffer
  (setq dired-dwim-target t)

  ;; enable some really cool extensions like C-x C-j(dired-jump)
  (require 'dired-x))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(use-package rainbow-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode))

(use-package whitespace
  :init
  (dolist (hook '(prog-mode-hook text-mode-hook))
    (add-hook hook #'whitespace-mode))
  (add-hook 'before-save-hook #'whitespace-cleanup)
  :config
  (setq whitespace-line-column 120) ;; limit line length
  (setq whitespace-style '(face tabs empty trailing lines-tail)))

(use-package clojure-mode
  :ensure t
  :config
  (add-hook 'clojure-mode-hook #'subword-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode))

(use-package cider
  :ensure t
  :requires (clojure-mode smartparens f)
  :init
  (setq cider-repl-pop-to-buffer-on-connect nil
        cider-repl-wrap-history t
        cider-repl-history-size 1000
        cider-repl-history-file (f-expand ".cider-history" user-emacs-directory)
        nrepl-hide-special-buffers t)
  :config
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
  (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
  (setq cider-repl-display-help-banner nil))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package imenu-anywhere
  :ensure t
  :bind (("C-c i" . imenu-anywhere)
         ("s-i" . imenu-anywhere)))

(use-package flyspell
  :config
  (when (eq system-type 'windows-nt)
    (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/"))
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra"))
  (add-hook 'text-mode-hook #'flyspell-mode)
  (add-hook 'prog-mode-hook #'flyspell-prog-mode))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))



(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))

(use-package ivy
  :ensure t
  :config
    (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume))

(use-package swiper
  :ensure t
  :config
  (global-set-key "\C-s" 'swiper))


;; This was actually borrowed from Prelude/packages/prelude-company.el
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.1)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode 1))


;;; PURCELL MODE
(use-package session
  :ensure t
  :config
  (setq session-save-file (expand-file-name ".session" user-emacs-directory))
  (setq session-name-disable-regexp "\\(?:\\`'/tmp\\|\\.git/[A-Z_]+\\'\\)")
  (setq session-save-file-coding-system 'utf-8))

(setq use-file-dialog nil)
(setq use-dialog-box nil)


;; TODO: look into maybe a better way of sayign this?
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(setq-default
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 case-fold-search t
 column-number-mode t
 make-backup-files nil
 set-mark-command-repeat-pop t
 truncate-lines nil
 truncate-partial-width-windows nil)

;; TODO: determine if this does jack squat
(when (fboundp 'global-prettify-symbols-mode)
  (add-hook 'after-init-hook 'global-prettify-symbols-mode))

(defvar desktop-path (list user-emacs-directory))
(defvar desktop-auto-save-timeout 600)
(desktop-save-mode 1)

(setq-default history-length 1000)
(add-hook 'after-init-hook 'savehist-mode)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(defvar desktop-globals-to-save
      (append '((comint-input-ring        . 50)
                (compile-history          . 30)
                desktop-missing-file-warning
                (dired-regexp-history     . 20)
                (extended-command-history . 30)
                (face-name-history        . 20)
                (file-name-history        . 100)
                (grep-find-history        . 30)
                (grep-history             . 30)
                (ido-buffer-history       . 100)
                (ido-last-directory-list  . 100)
                (ido-work-directory-list  . 100)
                (ido-work-file-list       . 100)
                (ivy-history              . 100)
                (magit-read-rev-history   . 50)
                (minibuffer-history       . 50)
                (org-clock-history        . 50)
                (org-refile-history       . 50)
                (org-tags-history         . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                register-alist
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                tags-table-list)))

;;; Possibly enable this if I'm feelign lucky punk

;; (require-package 'multiple-cursors)
;; ;; multiple-cursors
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-+") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; ;; From active region to multiple cursors:
;; (global-set-key (kbd "C-c m r") 'set-rectangular-region-anchor)
;; (global-set-key (kbd "C-c m c") 'mc/edit-lines)
;; (global-set-key (kbd "C-c m e") 'mc/edit-ends-of-lines)
;; (global-set-key (kbd "C-c m a") 'mc/edit-beginnings-of-lines)

;;; CJohansen

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
(global-set-key (kbd "M-t p") 'transpose-params)

(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-x C--") 'rotate-windows)

(global-set-key (kbd "C-c b") 'create-scratch-buffer)

(setq font-lock-maximum-decoration t)

(defvar color-theme-is-global t)

(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))

(use-package diminish
  :ensure t
  :config
  (eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
  (eval-after-load "eldoc" '(diminish 'eldoc-mode))
  (eval-after-load "tagedit" '(diminish 'tagedit-mode))
  (eval-after-load "elisp-slime-nav" '(diminish 'elisp-slime-nav-mode))
  (eval-after-load "skewer-mode" '(diminish 'skewer-mode))
  (eval-after-load "skewer-css" '(diminish 'skewer-css-mode))
  (eval-after-load "skewer-html" '(diminish 'skewer-html-mode))
  (eval-after-load "smartparens" '(diminish 'smartparens-mode))
  (eval-after-load "guide-key" '(diminish 'guide-key-mode))
  (eval-after-load "whiteqspace-cleanup-mode" '(diminish 'whitespace-cleanup-mode))
  (eval-after-load "company" '(diminish 'company-mode))
  (eval-after-load "ivy" '(diminish 'ivy-mode))
  (eval-after-load "which-key" '(diminish 'which-key-mode))
  (eval-after-load "linum-relative" '(diminish 'linum-relative-mode))
  (eval-after-load "subword" '(diminish 'subword-mode))
  (eval-after-load "whitespace" '(diminish 'whitespace-mode))
  (eval-after-load "rainbow-mode" '(diminish 'rainbow-mode))
  (eval-after-load "flyspell" '(diminish 'flyspell-mode)))

;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)

;; Transparently open compressed files
(auto-compression-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 120)

;; Undo/redo window configuration with C-c <left>/<right>
(winner-mode 1)

;; Easily navigate sillycased words
(global-subword-mode 1)

(use-package linum-relative
  :ensure t
  :config
  (global-linum-mode t)
  (linum-relative-mode t)
  (setq linum-relative-backend 'linum-mode
        linum-relative-current-symbol ""))

(use-package hlinum
  :ensure t
  :config
  (hlinum-activate))

(use-package suggest
  :ensure t)

(use-package swift-mode
  :ensure t)

(use-package clj-refactor
  :ensure t
  :config
)

;;; Find commands
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-l") 'find-library)

;;; wrap keybindings
;; FIXME: Pick terminal-friendly binding.
;;(define-key lisp-mode-shared-map (kbd "M-[") (prelude-wrap-with "["))
(define-key lisp-mode-shared-map (kbd "M-\"")
  (lambda (&optional arg)
    (interactive "P")
    (sp-wrap-with-pair "\"")))

(setq next-screen-context-lines 10
      scroll-preserve-screen-position t)

(provide 'init)

;;; init.el ends here
