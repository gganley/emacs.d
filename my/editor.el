(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t
   )

(defun single-font-size ()
  "Reset all faces to the height of the default face."
  (dolist (f (face-list))
    (when (not (equal 'default f))
      (set-face-attribute f nil :height 1.0))))

(add-hook 'after-init-hook 'single-font-size)

(when (window-system)
  (use-package git-gutter-fringe
    :ensure t))

(global-git-gutter-mode +1)

(setq-default indicate-buffer-boundaries 'left)
(setq-default indicate-empty-lines +1)

(winner-mode)
(windmove-default-keybindings)

(add-to-list 'default-frame-alist '(font . "Monaco-11"))
(set-default-font "Monaco-11")

(setq-default history-length 1000)
(add-hook 'after-init-hook 'savehist-mode)

;; Loads newest version of a file
(setq load-prefer-newer t)

(use-package smex
  :bind (("M-x" . smex)
	 ("M-X" . smex-major-mode-commands))  
  :config
  (smex-initialize))

(use-package use-package-ensure-system-package
  :ensure t)

(use-package which-key
  :diminish
  :config
  (which-key-mode +1))

(setq-default case-fold-search t)

;; Jump around buffer more effectivly
(use-package avy
  :bind (("s-." . avy-goto-word-or-subword-1)
         ("s-," . avy-goto-char))
  :config
  (setq avy-background t))

(use-package ivy
  :diminish
  :bind ("C-x b" . ivy-switch-buffer))

(use-package neotree
  :bind ([f8] . neotree-toggle))

;; (use-package dashboard
;;   :config
;;   (setq dashboard-items '((projects . 5)
;;                           (recents  . 10)))
;;   (dashboard-setup-startup-hook))

(use-package swiper
  :config
  (global-set-key (kbd "C-s") 'swiper))

(use-package linum-relative
  :config
  (global-linum-mode t)
  (linum-relative-mode t)
  (set-face-attribute 'linum-relative-current-face nil :height 100)
  (setq linum-relative-backend 'linum-mode
        linum-relative-current-symbol ""
	relative-line-numbers-motion-function 'forward-visible-line
	linum-relative-format "%4s"
	solarized-scale-org-headlines nil))

(use-package counsel
  :bind (("C-x C-f" . counsel-find-file)
         ("C-h f" . counsel-describe-function)
         ("C-h v" . counsel-describe-variable)
         ("M-y" . counsel-yank-pop)
         ("M-x" . counsel-M-x)))

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch))
  :config
  (setq-default magit-diff-refine-hunk t))

(use-package projectile
  :bind (("s-p" . projectile-command-map))
  :config
  (projectile-mode +1))

(use-package smartparens
  :ensure t
  :diminish
  :bind
  (("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)
   ("C-M-e" . sp-up-sexp)
   ("C-M-d" . sp-down-sexp)
   ("C-M-n" . sp-next-sexp)
   ("C-M-p" . sp-previous-sexp)
   ("C-M-t" . sp-transpose-sexp)
   ("M-D" . sp-splice-sexp)
   ("C-M-k" . sp-kill-sexp)
   ("C-M-w" . sp-copy-sexp)
   ("C-)" . sp-forward-slurp-sexp)
   ("C-M-)" . sp-forward-barf-sexp)
   ("C-M-r" . sp-raise-sexp))
  :hook (prog-mode . smartparens-strict-mode)
  :config
  (require 'smartparens-config)
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
    (sp-local-pair "{" nil :wrap "C-{"))
  (sp-with-modes '(org-mode)
    (sp-local-pair "~" nil :wrap "C-~")))


(use-package rainbow-delimiters
  :config
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package prettify-symbols
  :init
  (global-prettify-symbols-mode 1)
  :hook (prog-mode . prettify-symbols-mode))

(use-package yasnippet
  :requires yasnippet-snippets
  :bind ("C-c C-s" . yas-expand)
  :hook (prog-mode . yas-minor-mode)
  :config
  
  (add-to-list 'yas-snippet-dirs '("~/.emacs.d/snippets")))

(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package company)



(fset 'yes-or-no-p-history 'y-or-n-p)
(add-hook 'prog-mode-hook 'linum-mode)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))



(load-theme 'spacemacs-dark t)




;; Stolen from (http://endlessparentheses.com/ansi-colors-in-the-compilation-buffer-output.html
(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

;; Stolen from (https://oleksandrmanzyuk.wordpress.com/2011/11/05/better-emacs-shell-part-i/)
(defun regexp-alternatives (regexps)
  "Return the alternation of a list of regexps."
  (mapconcat (lambda (regexp)
               (concat "\\(?:" regexp "\\)"))
             regexps "\\|"))

(defvar non-sgr-control-sequence-regexp nil
  "Regexp that matches non-SGR control sequences.")

(setq non-sgr-control-sequence-regexp
      (regexp-alternatives
       '(;; icon name escape sequences
         "\033\\][0-2];.*?\007"
         ;; non-SGR CSI escape sequences
         "\033\\[\\??[0-9;]*[^0-9;m]"
         ;; noop
         "\012\033\\[2K\033\\[1F"
         )))

(defun filter-non-sgr-control-sequences-in-region (begin end)
  (save-excursion
    (goto-char begin)
    (while (re-search-forward
            non-sgr-control-sequence-regexp end t)
      (replace-match ""))))

(defun filter-non-sgr-control-sequences-in-output (ignored)
  (let ((start-marker
         (or comint-last-output-start
             (point-min-marker)))
        (end-marker
         (process-mark
          (get-buffer-process (current-buffer)))))
    (filter-non-sgr-control-sequences-in-region
     start-marker
     end-marker)))

(add-hook 'comint-output-filter-functions
          'filter-non-sgr-control-sequences-in-output)

(provide 'my-editor)
