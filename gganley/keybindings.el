;; Smex init
(global-set-key (kbd "M-x") 'smex)

;; better dired
(global-set-key (kbd "C-c d") 'direx:jump-to-directory)

;; Something broke my C-x C-s
(global-set-key (kbd "C-x C-s") 'save-buffer)

;; Call me an i3 fanboy but this works great for me
(global-set-key (kbd "C-c j") 'windmove-left)
(global-set-key (kbd "C-c k") 'windmove-down)
(global-set-key (kbd "C-c l") 'windmove-up)
(global-set-key (kbd "C-c ;") 'windmove-right)

;; Set it to something sensible
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Org shit
(global-set-key (kbd "C-c c") 'org-capture)
(define-key org-mode-map (kbd "C-c i") '(lambda () (interactive)(insert "#+BEGIN_SRC emacs-lisp\n#+END_SRC")))

;; Smart parens
(global-set-key (kbd "C-)") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-(") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-M-)") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-M-(") 'sp-backward-barf-sexp)

(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]  
             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
  (global-unset-key k))
(provide 'keybindings)
