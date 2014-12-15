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
(provide 'haskell-config)
(add-hook 'haskell-mode-hook 'structured-haskell-mode)
