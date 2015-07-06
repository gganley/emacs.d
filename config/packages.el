(require 'package)
(require 'cl-lib)
(eval-when-compile (require 'cl))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(defvar gcg/packages
  '(cl-lib
    haskell-mode
    rainbow-delimiters
    paredit
    flycheck
    magit
    solarized-theme
    smex
    linum-relative
    direx))
(defun packages-installed-p ()
  (every #'package-installed-p gcg/packages))
(defun require-package (package)
  (unless (memq package gcg/packages)
    (add-to-list 'gcg/packages package))
  (unless (package-installed-p package)
    (package-install package)))
(defun require-packages (packages)
  (mapc #'require-package packages))
(defun install-packages ()
  (unless (packages-installed-p)
    (package-refresh-contents)
    (require-packages gcg/packages)))

(install-packages)
(defun list-foreign-packages ()
  (interactive)
  (package-show-package-list
   (set-difference package-activated-list gcg/packages)))
(defmacro auto-install (extension package mode)
  `(add-to-list 'auto-mode-alist
		`(,extension . (lambda ()
				 (unless (package-installed-p ',package)
				   (package-install ',package))
				 (,mode)))))

(defvar auto-install-alist
  '(("\\.hs\\'" haskell-mode haskell-mode)
    ("\\.clj\\'" clojure-mode clojure-mode)))
(mapc
 (lambda (entry)
   (let ((extension (car entry))
	 (package (cadr entry))
	 (mode (cadr (cdr entry))))
     (unless (package-installed-p package)
       (auto-install extension package mode))))
 auto-install-alist)
(provide 'packages)
