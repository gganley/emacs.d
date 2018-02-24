;; This was actually borrowed from Prelude/packages/prelude-company.el
(use-package company
  :ensure t
  :diminish
  :init
  (add-hook 'prog-mode-hook #'company-mode)
  (global-set-key (kbd "M-<tab>") #'company-complete)
  :config
  (setq company-idle-delay nil)
  (setq company-tooltip-limit 15)
  (setq company-minimum-prefix-length 2)
  ;; Don't flip the direction, that shit is tedious
  (setq company-tooltip-flip-when-above nil))

(provide 'init-company)
