;; my emacs setup
(setq debug-on-error t)

;; Setup use-package
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
(package-refresh-contents)

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
(setq package-enable-at-startup nil)

;; Start our emacs server
(server-start)

;; Load hidden.el
(if (file-exists-p "hidden.el")
    (load-file "hidden.el"))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      indent-tabs-mode nil)

(subword-mode t)

;; packages
(use-package cl)
(use-package s :ensure t)
(use-package ag)
(use-package dockerfile-mode)
(use-package markdown-mode)
(use-package ruby-mode)
(use-package sbt-mode)
(use-package scala-mode)
(use-package yaml-mode)
(use-package json-reformat)
(use-package go-mode)
(use-package exec-path-from-shell)
(use-package rust-mode)
(use-package groovy-mode)
(use-package vlf)

(use-package terraform-mode
  :config (setq terraform-indent-level 2))

(use-package ido-vertical-mode
  :init (progn
          (ido-mode 1)
          (ido-vertical-mode 1)
          (setq ido-vertical-define-keys 'C-n-and-C-p-only)))

(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-*" . mc/mark-all-like-this)))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package smex
  :bind (("M-x" . smex)))

(use-package switch-window
  :bind ("C-x o" . switch-window))

(use-package expand-region
  :bind ("C-c C-w" . er/expand-region)
  :init (progn (pending-delete-mode t)))

(use-package highlight-parentheses
  :init (progn (global-highlight-parentheses-mode)))

(use-package ido
  :init (progn (ido-mode t)))

;; uniquify
(setq uniquify-buffer-name-style 'post-forward)

;; mine/* configs
(add-to-list 'load-path "~/.emacs.d/mine")
(require 'mine-env)
(require 'mine-builtin)
(require 'mine-defuns)
(require 'mine-tramp)
(require 'mine-languages)
(require 'mine-mode-line)
(require 'mine-eshell)
(require 'mine-pretty)
(require 'mine-org)
(require 'mine-sbt)
(require 'mine-magit)
(require 'mine-rcirc)
(require 'mine-bindings) ;; Load bindings after everything else

;; Load random elisp straight into *your* emacs config!
(defun load-random-elsip(dir)
  (if (file-exists-p dir)
      (let ((custom-files (directory-files dir t "\.el$")))
        (mapcar 'load-file custom-files))))

;; load custom files
(load-random-elsip "~/.emacs.d/custom/")

(put 'dired-find-alternate-file 'disabled nil)
(put 'ido-exit-minibuffer 'disabled nil)
(put 'upcase-region 'disabled nil)
