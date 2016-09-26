;; emacs setup
(setq debug-on-error t)

(server-start)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      indent-tabs-mode nil)

(subword-mode t)

;; setup use-package
(push "~/.emacs.d/use-package/" load-path)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(require 'package)
(require 'use-package)

(package-initialize)
(package-refresh-contents)

;; packages
(use-package s :ensure t)
(use-package ag :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package markdown-mode :ensure t)
(use-package ruby-mode :ensure t)
(use-package sbt-mode :ensure t)
(use-package scala-mode :ensure t)
(use-package yaml-mode :ensure t)
(use-package json-reformat :ensure t)
(use-package go-mode :ensure t)
(use-package exec-path-from-shell :ensure t)
(use-package rust-mode :ensure t)

(use-package terraform-mode
  :ensure t
  :config (setq terraform-indent-level 2))

(use-package ido-vertical-mode
  :init (progn
          (ido-mode 1)
          (ido-vertical-mode 1)
          (setq ido-vertical-define-keys 'C-n-and-C-p-only))
  :ensure t)

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-*" . mc/mark-all-like-this)))

(use-package magit
  :bind ("C-x g" . magit-status)
  :ensure t)

(use-package magit-gh-pulls
  :ensure t)

(use-package smex
  :bind (("M-x" . smex))
  :ensure t)

(use-package switch-window
  :bind ("C-x o" . switch-window)
  :ensure t)

(use-package expand-region
  :bind ("C-c C-w" . er/expand-region)
  :init (progn (pending-delete-mode t))
  :ensure t)

(use-package highlight-parentheses
  :init (progn (global-highlight-parentheses-mode))
  :ensure t)

(use-package ido
  :init (progn (ido-mode t)))

(use-package uniquify
  :init (progn
          (setq
           uniquify-buffer-name-style 'post-forward
           uniquify-separator ":")))

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
