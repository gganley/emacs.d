;;; Org area
(setq org-directory user-emacs-directory
      org-default-notes-file (expand-file-name "notes.org" "~"))

(use-package org
  :ensure t
  :config
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (add-hook 'org-mode-hook
            (lambda () (face-remap-add-relative 'default :family "Monospace")))
  (setq org-src-fontify-natively t)
  ;; Taken from this post pragmaticemacs.com/emacs/wrap-text-in-an-org-mode-block/
  (defun org-begin-template ()
    "Make a template at point."
    (interactive)
    (if (org-at-table-p)
        (call-interactively 'org-table-rotate-recalc-marks)
      (let* ((choices '(("s" . "SRC")
                        ("e" . "EXAMPLE")
                        ("q" . "QUOTE")
                        ("v" . "VERSE")
                        ("c" . "CENTER")
                        ("l" . "LaTeX")
                        ("h" . "HTML")
                        ("a" . "ASCII")))
             (key
              (key-description
               (vector
                (read-key
                 (concat (propertize "Template type: " 'face 'minibuffer-prompt)
                         (mapconcat (lambda (choice)
                                      (concat (propertize (car choice) 'face 'font-lock-type-face)
                                              ": "
                                              (cdr choice)))
                                    choices
                                    ", ")))))))
        (let ((result (assoc key choices)))
          (when result
            (let ((choice (cdr result)))
              (cond
               ((region-active-p)
                (let ((start (region-beginning))
                      (end (region-end)))
                  (goto-char end)
                  (insert "\n" "#+END_" choice "\n")
                  (goto-char start)
                  (insert "#+BEGIN_" choice "\n")))
               (t
                (insert "#+BEGIN_" choice "\n")
                (save-excursion (insert "#+END_" choice "\n"))))))))))
  ;;bind to key
  (define-key org-mode-map (kbd "C-<") 'org-begin-template))


(provide 'init-org)
