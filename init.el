;;; package --- Summary:

;;; Commentary:

;; -*- lexical-binding: t -*-

;;; Most of this is taken from bbatsov so thanks to him
;;; More of it is taken and I've attempted to keep track

;;; Code:

(setq debug-on-error t
      debug-on-signal nil
      debug-on-quit nil)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Purcell
;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'after-init-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-elpa)
(require 'init-themes)
(require 'init-exec-path)
(require 'init-editor)
(require 'init-os)
(require 'init-lisp)
(require 'init-company)
(require 'init-clojure)
