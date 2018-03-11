;; This was actually borrowed from Prelude/packages/prelude-company.el
(use-package company
  :ensure t
  :diminish
  :init
  (global-set-key (kbd "M-<tab>") #'company-complete)
  (add-hook 'prog-mode-hook #'company-mode)
  :config
  (setq company-idle-delay nil)
  (setq company-tooltip-limit 15)
  (setq company-minimum-prefix-length 2)
  ;; Don't flip the direction, that shit is tedious
  (setq company-tooltip-flip-when-above nil))

(provide 'init-company)
