;;; package --- Summary:

;;; Commentary:

;; -*- lexical-binding: t -*-

;;; Most of this is taken from bbatsov so thanks to him
;;; More of it is taken and I've attempted to keep track

;;; Code:


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Package independent
(setq debug-on-error t
      debug-on-signal nil
      debug-on-quit nil
      inhibit-startup-screen t
      inhibit-startup-echo-area-message "Hello GGANLEY")

(set-default-coding-systems 'utf-8)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(defun get-fullpath (@file-relative-path)
  (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path))


(when (fboundp 'get-fullpath)
    (require 'my-package (get-fullpath "my/package.el"))
    (require 'my-editor (get-fullpath "my/editor.el"))
    (require 'my-rust (get-fullpath "my/rust.el"))
    (require 'my-org (get-fullpath "my/org.el"))
    (require 'my-go (get-fullpath "my/go.el")))
    (require 'my-python (get-fullpath "my/python.el"))

(provide 'init)
;;; init.el ends here
