(dolist (hook '(prog-mode-hook))
  (add-hook hook (lambda () (setq truncate-lines t))))

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))


(add-to-list 'default-frame-alist '(fullscreen . fullboth))

(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))


;; Transparently open compressed files
(auto-compression-mode t)

;; Undo/redo window configuration with C-c <left>/<right>
(winner-mode 1)

(defvar desktop-path (list user-emacs-directory))
(defvar desktop-auto-save-timeout 30)
(desktop-save-mode 1)

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


;; Use utf-8, please
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(global-hl-line-mode +1)

;; Act like a goddamn modern editor
(delete-selection-mode t)

;; Don't distract me
(blink-cursor-mode -1)

;; Don't annoy me
(setq ring-bell-function 'ignore)

;; Don't give me useless information
(setq inhibit-startup-screen t)

;; Number of lines preserved at the top and bottom
(setq scroll-margin 1)

;; Now this is a god damn variable name, only needs to be suffixed by -when-scrolling
(setq scroll-preserve-screen-position t)

;; Is annoying as fuck during a dark mode
(if (fboundp 'set-scroll-bar-mode)
    (set-scroll-bar-mode nil))

(when (fboundp 'pixel-scroll-mode)
  (pixel-scroll-mode 1))

(setq next-screen-context-lines 10
      scroll-preserve-screen-position t)


;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)

(setq-default bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
              case-fold-search t
              column-number-mode t
              truncate-lines nil
              truncate-partial-width-windows nil)

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

;; TODO: determine if this does jack squat
(when (fboundp 'global-prettify-symbols-mode)
  (add-hook 'after-init-hook 'global-prettify-symbols-mode))

(use-package autorevert
  :delight auto-revert-mode
  :config
  ;; Global Auto-Revert Mode is a global minor mode that reverts any
  ;; buffer associated with a file when the file changes on disk
  (global-auto-revert-mode t))

;; Jump around buffer more effectivly
(use-package avy
  :ensure t
  :bind (("s-." . avy-goto-word-or-subword-1)
         ("s-," . avy-goto-char))
  :config
  (setq avy-background t))

;; Spell checking
(use-package flyspell
  :diminish
  :config
  (when (eq system-type 'windows-nt)
    (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/"))
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra"))
  (add-hook 'text-mode-hook #'flyspell-mode)
  (add-hook 'prog-mode-hook #'flyspell-prog-mode))

(use-package ivy
  :ensure t
  :diminish
  :init
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t))

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

;; Taken from weavejester
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :bind ("C-c C-s" . yas-expand)
  :init
  (use-package yasnippet-snippets :ensure t :diminish)
  (use-package clojure-snippets :ensure t :diminish)
  :config
  (define-key yas-minor-mode-map (kbd "SPC") yas-maybe-expand)
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(use-package subword
  :diminish
  :init
  (global-subword-mode 1))

(use-package linum-relative
  :ensure t
  :config
  (global-linum-mode t)
  (linum-relative-mode t)
  (set-face-attribute 'linum nil :height 90)
  (setq linum-relative-backend 'linum-mode
        linum-relative-current-symbol ""))

(use-package hlinum
  :ensure t
  :config
  (hlinum-activate))

(use-package flycheck
  :ensure t
  :diminish)

(provide 'init-editor)
