;; emacs setup
(setq debug-on-error t)

(server-start)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      indent-tabs-mode nil)

(setenv "PATH" (concat (getenv "HOME") "/bin" ":"
                       "/usr/local/bin" ":"
                       "/usr/bin" ":"
                       "/bin" ":"
                       "/sbin" ":"
                       ))

(push "/Users/adam/bin" exec-path)
(push "/usr/local/bin" exec-path)

;; env steup
(setenv "ESHELL" "bash")
(setenv "DOCKER_HOST" "tcp://192.168.59.103:2375")
;; (setenv "DOCKER_CERT_PATH" "/Users/adam/.docker/boot2docker-vm")

;; setup use-package
(push "~/.emacs.d/use-package/" load-path)

(require 'package)
(require 'use-package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)
(package-refresh-contents)

;; packages
(use-package s :ensure t)
(use-package ag :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package markdown-mode :ensure t)
(use-package projectile :ensure t)
(use-package clojure-mode :ensure t)
(use-package haskell-mode :ensure t)
(use-package ruby-mode :ensure t)
(use-package sbt-mode :ensure t)
(use-package scala-mode2 :ensure t)
(use-package yaml-mode :ensure t)
(use-package json-reformat :ensure t)
(use-package go-mode :ensure t)
(use-package php-mode :ensure t)
(use-package less-css-mode :ensure t)
(use-package rainbow-mode :ensure t)
(use-package color-theme-wombat :ensure t)
;; (use-package gist :ensure t)

(use-package ido-vertical-mode
  :init (progn
          (ido-mode 1)
          (ido-vertical-mode 1))
  :ensure t)

;; w3m
(use-package json :ensure t)
(use-package request :ensure t)
(use-package w3m :ensure t)

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-*" . mc/mark-all-like-this)))

(use-package magit
  :bind ("C-x g" . magit-status)
  :ensure t)

(use-package smex
  :bind (("M-x" . smex))
  :ensure t)

(use-package switch-window
  :bind ("C-x o" . switch-window)
  :ensure t)

(use-package smartparens
  :init (progn
          (require 'smartparens-config)
          (smartparens-global-strict-mode)))

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
(require 'mine-builtin)
(require 'mine-defuns)
(require 'mine-bindings)
(require 'mine-commands)
(require 'mine-languages)
(require 'mine-mode-line)
(require 'mine-w3m)
(require 'mine-pretty)

;; language / tool specifics
(require 'mine-sbt)

(mode-line-off)

(setq mine-custom-dir "~/.emacs.d/custom/")
(if (file-exists-p mine-custom-dir)
 (let ((custom-files (directory-files mine-custom-dir t "\.el$")))
  (mapcar 'load-file custom-files)))

(setq custom-file (expand-file-name "~/.emacs.d/customizations.el"))
(load custom-file)

(put 'dired-find-alternate-file 'disabled nil)
(put 'ido-exit-minibuffer 'disabled nil)
