;;; package --- Summary:

;;; Commentary:

;; -*- lexical-binding: t -*-

;;; Most of this is taken from bbatsov so thanks to him
;;; More of it is taken and I've attempted to keep track

;;; Code:


;; Enter debugger if error is signaled
(setq debug-on-error t
      debug-on-signal nil
      debug-on-quit nil)

(require 'package)
(setq is-a-mac (eq system-type 'darwin))

(if is-a-mac
    (set-face-attribute 'default t :font "Monaco-9")
  (set-face-attribute 'default t :font "Source Code Pro-10"))

(when is-a-mac
  (setq ns-use-native-fullscreen t)
  (set-frame-parameter nil 'fullscreen 'fullboth))

;; Don't fuck up my init.el
(setq custom-file (expand-file-name ".emacs-custom.el" user-emacs-directory))
(load custom-file)

;; melpa, THE ONE TRUE PACKAGE ARCHIVE
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; This puts all of the things into one goddamn directory
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Loads newest version of a file
(setq load-prefer-newer t)

;; I have a billion bytes, use a portion
(setq gc-cons-threshold 50000000)

(defconst savefile-dir (expand-file-name "savefile" user-emacs-directory))

;; Use load-path
(defvar flycheck-emacs-lisp-load-path 'inherit)

;; Disable tool-bar-mode, more for windows and shit but yeah
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Likewise for menubar
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

;; Don't distract me
(blink-cursor-mode -1)

;; Don't annoy me
(setq ring-bell-function 'ignore)

;; Don't give me useless information
(setq inhibit-startup-screen t)

;; Number of lines preserved at the top and bottom
(setq scroll-margin 15)

;; Now this is a god damn variable name, only needs to be suffixed by -when-scrolling
(setq scroll-preserve-screen-position t)

;; Is annoying as fuck during a dark mode
(toggle-scroll-bar -1)

;; Toggle buffer size display in the mode line
(size-indication-mode t)

;; obvious, don't know why I need fset though
(fset 'yes-or-no-p 'y-or-n-p)

;; Set default tabbing behavior
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

;; Looks prettier
(setq require-final-newline t)

;; Act like a goddamn modern browser
(delete-selection-mode t)

;; I don't want your backups cluttering my working directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))



;; Use utf-8, please
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(global-hl-line-mode +1)

;; gives a pretty buffer switcher
(global-set-key (kbd "C-x C-b") #'ibuffer)

(define-key 'help-command (kbd "C-i") #'info-display-manual)

(setq tab-always-indent 'complete)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; I don't need escape bound to this
(define-key input-decode-map [?\C-\[] (kbd "<C-[>"))

(require 'use-package)

(use-package diminish
  :ensure t)

(use-package autorevert
  :delight auto-revert-mode
  :config
  ;; Global Auto-Revert Mode is a global minor mode that reverts any
  ;; buffer associated with a file when the file changes on disk
  (global-auto-revert-mode t))

(use-package rainbow-delimiters
  :ensure t
  :delight)

;; Interactive elisp
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

;; Jump around buffer more effectivly
(use-package avy
  :ensure t
  :bind (("s-." . avy-goto-word-or-subword-1)
         ("s-," . avy-goto-char))
  :config
  (setq avy-background t))

;; Theme I use, made by the kinklessGTD fella
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

;; Helps you manage sexps
(use-package rainbow-delimiters
  :ensure t)

;; Git manager
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package projectile
  :ensure t
  :bind ("s-p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

;; TODO: What the fuck does this do
(use-package elisp-slime-nav
  :ensure t
  :config
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook #'elisp-slime-nav-mode)))

;; Makes working with sexps bearable
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
   ("C-M-)" . sp-forward-barf-sexp)
   ("C-M-r" . sp-raise-sexp))
  :config
  (add-hook 'prog-mode-hook #'smartparens-strict-mode)
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "'" nil :actions nil))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "`" nil :actions nil))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "(" nil :wrap "C-("))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "\"" nil :wrap "C-\""))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "[" nil :wrap "<C-[>"))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "#{" "}" :wrap "C-#"))
  (sp-with-modes sp-lisp-modes
    (sp-local-pair "{" nil :wrap "C-{")))

;; Highlight current sexp's parens
(use-package paren
  :config
  (show-paren-mode +1))

;; Save the place I last was in the buffer
(use-package saveplace
  :config
  (setq save-place-file (expand-file-name "saveplace" savefile-dir))
  ;; activate it for all buffers
  (setq-default save-place t))

;; Save minibuffer history
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
        recentf-max-menu-items 15)
  (recentf-mode +1))

;; Shift-{left,right,up,down}
(use-package windmove
  :config
  ;; use shift + arrow keys to switch between visible buffers
  (windmove-default-keybindings))

;; Dired is the one true way of navigating through directories
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
  ;; C-x C-j (dired-jump): Jump to Dired buffer corresponding to current buffer.
  (require 'dired-x))

;; On OS X (and perhaps elsewhere) the $PATH environment variable and
;; `exec-path' used by a windowed Emacs instance will usually be the
;; system-wide default path, rather than that seen in a terminal
;; window.
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

;; sexps are now KappaPride
(use-package rainbow-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode))

;; Highlight whitespace
(use-package whitespace
  :init
  (dolist (hook '(prog-mode-hook))
    (add-hook hook #'whitespace-mode))
  (add-hook 'before-save-hook #'whitespace-cleanup)
  :config
  (setq whitespace-line-column 140) ;; limit line length
  (setq whitespace-style '(face tabs empty trailing lines-tail)))

(use-package clojure-mode
  :ensure t
  :config
  (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
  (add-hook 'clojure-mode-hook #'subword-mode)
  (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode))

(use-package cider
  :ensure t
  :config
  (setq cider-repl-display-help-banner nil)
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
  (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode))

;; TODO:
;; Understand how I want to arrange my dependencies because right now
;; there are constantly a shit ton of weird behaviors


(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multi-markdown"
              markdown-hide-urls t)
  :config
  (add-hook 'markdown-mode-hook #'visual-line-mode))

;; Spell checking
(use-package flyspell
  :config
  (when (eq system-type 'windows-nt)
    (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/"))
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra"))
  (add-hook 'text-mode-hook #'flyspell-mode)
  (add-hook 'prog-mode-hook #'flyspell-prog-mode))

;; Compile time checking
(use-package flycheck
  :ensure t
  :config
  (dolist (hook '(prog-mode-hook))
    (add-hook hook #'flycheck-mode)))

;; Essential, pops a menu for keyboard prefixs
(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))

;; TODO: what does this do...
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key (kbd "<f6>") 'ivy-resume))

;; A better search
(use-package swiper
  :ensure t
  :config
  (global-set-key "\C-s" 'swiper))

(use-package counsel
  :ensure t
  :bind (("C-x C-f" . counsel-find-file)
         ("C-h f" . counsel-describe-function)
         ("C-h v" . counsel-describe-variable)
         ("M-y" . counsel-yank-pop)))
(use-package buffer-move
  :ensure t
  :config
  (global-set-key (kbd "<C-S-up>")     'buf-move-up)
  (global-set-key (kbd "<C-S-down>")   'buf-move-down)
  (global-set-key (kbd "<C-S-left>")   'buf-move-left)
  (global-set-key (kbd "<C-S-right>")  'buf-move-right))


;; This was actually borrowed from Prelude/packages/prelude-company.el
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.5)
  (setq company-tooltip-limit 15)
  (setq company-minimum-prefix-length 2)
  ;; Don't flip the direction, that shit is tedious
  (setq company-tooltip-flip-when-above nil)
  (dolist (hook '(prog-mode-hook))
    (add-hook hook #'company-mode)))


;; TODO: look into maybe a better way of sayign this?
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(setq-default bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
              case-fold-search t
              column-number-mode t
              truncate-lines nil
              truncate-partial-width-windows nil)

;; TODO: determine if this does jack squat
;; (when (fboundp 'global-prettify-symbols-mode)
;;   (add-hook 'after-init-hook 'global-prettify-symbols-mode))

(defvar desktop-path (list user-emacs-directory))
(defvar desktop-auto-save-timeout 30)
;; (desktop-save-mode 1)

(setq-default history-length 1000)
(add-hook 'after-init-hook 'savehist-mode)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(defvar desktop-globals-to-save
  (append '((comint-input-ring        . 50)
            (compile-history          . 30)
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
            (search-ring              . 20)
            (shell-command-history    . 50))))

;;; CJohansen

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
;; (global-unset-key (kbd "C-M-t")) ;; now this is set to sp-transpose-sexp
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
;; (global-set-key (kbd "M-t s") 'transpose-sexps) ;; Use C-M-t instead
(global-set-key (kbd "M-t p") 'transpose-params)

;; Kill up to, but not including ARGth occurrence of CHAR.
(global-set-key (kbd "M-z") 'zap-up-to-char)

(setq font-lock-maximum-decoration t)

(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))

;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)

;; Transparently open compressed files
(auto-compression-mode t)

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

;; Get some suggestions
(use-package suggest
  :ensure t)

(use-package clj-refactor
  :ensure t
  :init
  ;; Taken from weavejester
  (add-hook 'clojure-mode-hook (lambda () (clj-refactor-mode 1)))
  :config
  (cljr-add-keybindings-with-prefix "C-c m"))


;; Taken from weavejester
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  (use-package yasnippet-snippets)
  (use-package clojure-snippets))

;;; Find commands
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-l") 'find-library)

(setq next-screen-context-lines 10
      scroll-preserve-screen-position t)

;; Org area

(setq org-directory user-emacs-directory
      org-default-notes-file (expand-file-name "notes.org" org-directory))

(use-package org
  :ensure t
  :config
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture))

(add-hook 'org-mode-hook
          (lambda () (face-remap-add-relative 'default :family "Monospace")))

;; Make source blocks pretty
(setq org-src-fontify-natively t)

;; Taken from this post pragmaticemacs.com/emacs/wrap-text-in-an-org-mode-block/
(defun org-begin-template ()
  "Make a template at point."
  (interactive)
  (if (org-at-table-p)
      (call-interactively 'org-table-rotate-recalc-marks)
    (let* ((choices '(("s" . "SRC")
                      ("e" . "EXAMPLE")
                      ("q" . "QUOTE")
                      ("v" . "VERSE")
                      ("c" . "CENTER")
                      ("l" . "LaTeX")
                      ("h" . "HTML")
                      ("a" . "ASCII")))
           (key
            (key-description
             (vector
              (read-key
               (concat (propertize "Template type: " 'face 'minibuffer-prompt)
                       (mapconcat (lambda (choice)
                                    (concat (propertize (car choice) 'face 'font-lock-type-face)
                                            ": "
                                            (cdr choice)))
                                  choices
                                  ", ")))))))
      (let ((result (assoc key choices)))
        (when result
          (let ((choice (cdr result)))
            (cond
             ((region-active-p)
              (let ((start (region-beginning))
                    (end (region-end)))
                (goto-char end)
                (insert "\n" "#+END_" choice "\n")
                (goto-char start)
                (insert "#+BEGIN_" choice "\n")))
             (t
              (insert "#+BEGIN_" choice "\n")
              (save-excursion (insert "#+END_" choice "\n"))))))))))

;;bind to key
(define-key org-mode-map (kbd "C-<") 'org-begin-template)

(dolist (hook '(prog-mode-hook))
  (add-hook hook (lambda () (setq truncate-lines t))))

(provide 'init)

;;; init.el ends here
