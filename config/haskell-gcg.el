(require 'haskell-mode)
(require 'hindent)
(require 'haskell-process)
(require 'haskell-simple-indent)
(require 'haskell-font-lock)
(require 'haskell-debug)

(custom-set-variables
 '(haskell-process-type 'ghci)
 '(haskell-process-args-ghci '())
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
 '(haskell-process-do-cabal-format-string ":!cd %s && unset GHC_PACKAGE_PATH && %s")
 '(haskell-process-show-debug-tips nil)
 '(haskell-process-suggest-hoogle-imports nil)
 '(haskell-process-suggest-haskell-docs-imports t)
 '(hindent-style "chris-done")
 '(haskell-interactive-mode-eval-as-mode 'haskell-mode)
 '(haskell-process-path-ghci "ghci")
 '(haskell-process-args-ghci '("-ferror-spans"))
 '(haskell-process-args-cabal-repl '("--ghc-option=ferror-spans" "--with-ghc=ghci"))
 '(haskell-process-generate-tags nil))

(defun haskell-insert-doc ()
  "Insert the documentation syntax."
  (interactive)
  (insert "-- | "))

(defvar haskell-process-use-ghci nil)

(defun haskell-process-cabal-build-and-restart ()
  "Build and restart the Cabal project."
  (interactive)
  (cond
   (haskell-process-use-ghci
    (when (buffer-file-name)
      (save-buffer))
    ;; Reload main module where `main' function is
    (haskell-process-reload-devel-main))
   (t
    (haskell-process-cabal-build)
    (haskell-process-queue-without-filters
     (haskell-process)
     (format ":!cd %s && scripts/restart\n" (haskell-session-cabal-dir (haskell-session)))))
   (t (turbo-devel-reload))))

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(define-key haskell-mode-map [f5] 'haskell-process-load-or-reload)
(define-key haskell-mode-map [f8] 'haskell-navigate-imports)
(define-key haskell-mode-map [f9] 'haskell-interactive-mode-visit-error)
(define-key haskell-mode-map [f11] 'haskell-process-cabal-build)
(define-key haskell-mode-map [f12] 'haskell-process-cabal-build-and-restart)
(define-key haskell-mode-map (kbd "C-;") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "C-c i") 'hindent/reformat-decl)
(define-key haskell-mode-map (kbd "C-c C-a") 'haskell-insert-doc)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-mode-show-type-at)
(define-key haskell-mode-map (kbd "C-c C-v") 'haskell-interactive-toggle-print-mode)

(define-key haskell-cabal-mode-map [f9] 'haskell-interactive-mode-visit-error)
(define-key haskell-cabal-mode-map [f11] 'haskell-process-cabal-build)
(define-key haskell-cabal-mode-map [f12] 'haskell-process-cabal-build-and-restart)
(define-key haskell-cabal-mode-map (kbd "C-;") 'haskell-interactive-bring)
(define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)

(defun haskell-process-all-types ()
  "List all types in a grep-mode buffer."
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
      (unless (eq major-mode  'compilation-mode)
        (compilation-mode)
        (setq compilation-error-regexp-alist
              haskell-compilation-error-regexp-alist)))))
(provide 'haskell-gcg)
