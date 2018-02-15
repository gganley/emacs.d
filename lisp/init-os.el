;;; Emacs the operating system configuration

(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-l") 'find-library)

(setq is-a-mac (eq system-type 'darwin))

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

;; Toggle buffer size display in the mode line
(size-indication-mode t)

;; obvious, don't know why I need fset though
(fset 'yes-or-no-p 'y-or-n-p)

;; Set default tabbing behavior
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

;; Looks prettier
(setq require-final-newline t)


;; I don't want your backups cluttering my working directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; gives a pretty buffer switcher
(global-set-key (kbd "C-x C-b") #'ibuffer)

;; I don't need escape bound to this
(define-key input-decode-map [?\C-\[] (kbd "<C-[>"))

(use-package which-key
  :ensure t
  :diminish
  :config
  (which-key-mode +1))

(use-package buffer-move
  :ensure t
  :config
  (global-set-key (kbd "<C-S-up>")     'buf-move-up)
  (global-set-key (kbd "<C-S-down>")   'buf-move-down)
  (global-set-key (kbd "<C-S-left>")   'buf-move-left)
  (global-set-key (kbd "<C-S-right>")  'buf-move-right))

;; What did my change do?
(use-package restart-emacs
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

(provide 'init-os)
