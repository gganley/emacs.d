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

(provide 'keybindings)
