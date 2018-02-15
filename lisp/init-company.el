;; This was actually borrowed from Prelude/packages/prelude-company.el
(use-package company
  :ensure t
  :diminish
  :config
  (setq company-idle-delay 0.5)
  (setq company-tooltip-limit 15)
  (setq company-minimum-prefix-length 2)
  ;; Don't flip the direction, that shit is tedious
  (setq company-tooltip-flip-when-above nil)
  (dolist (hook '(prog-mode-hook))
    (add-hook hook #'company-mode)))

(provide 'init-company)
