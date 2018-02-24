;;; Commentary:

;; Handles all the responsibilities of the editor such as editing short cuts,
;; scrollbars, in-text search, etc

;;; Code:

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

;; Now this is a god damn variable name, only needs to be suffixed by
;; -when-scrolling
(setq scroll-preserve-screen-position t)

;; Is annoying as fuck during a dark mode
(if (fboundp 'set-scroll-bar-mode)
    (set-scroll-bar-mode nil))

;; Control the behavior of hard jumps such as C-v
(setq next-screen-context-lines 10
      scroll-preserve-screen-position t)


;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)

;; Display columns in modeline
(setq-default column-number-mode t)

;; Search even through folded text e.g. org-mode
(setq-default case-fold-search t)

;;; CJohansen
;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t p") 'transpose-paragraphs)

;; TODO: determine if this does jack squat
(when (fboundp 'global-prettify-symbols-mode)
  (add-hook 'after-init-hook 'global-prettify-symbols-mode))

(use-package esup
  :ensure t)

(use-package discover
  :ensure t)

(use-package autorevert
  :diminish auto-revert-mode
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
