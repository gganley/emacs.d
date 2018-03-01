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
(setq gc-cons-threshold (* 1024 1024 1024))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)
(require 'init-exec-path)
(require 'init-project)
(require 'init-editor)
(require 'init-themes)
(require 'init-os)
(require 'init-lisp)
(require 'init-clojure)
(require 'init-org)
(require 'init-prose)
(require 'init-company)
