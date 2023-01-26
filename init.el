;; my emacs setup
(setq debug-on-error t)

;; Setup use-package
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)

;; From https://emacs.stackexchange.com/a/18515
(defun internet-up-p (&optional host)
  (= 0 (call-process "ping" nil nil nil "-c" "1" "-W" "1"
                     (if host host "www.google.com"))))

;; Only try and refresh packages if we're online
(if (internet-up-p)
    (package-refresh-contents))

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
(setq package-enable-at-startup nil)

;; Load hidden.el
(let ((hidden-path "~/.emacs.d/hidden.el"))
  (if (file-exists-p hidden-path)
      (load-file hidden-path)))

;; Load the rest of the config from readme.org
;; (use-package org-plus-contrib)
;; (setq package-enable-at-startup nil)
;; (org-babel-load-file (concat user-emacs-directory "readme.org"))
;; todo: move everything below to init-old.el to slowly bring back into the main config
;;  - or to allow pulling things one-by-one into readme.org

(tool-bar-mode -1)
(menu-bar-mode -1)

(require 'scroll-bar)
(scroll-bar-mode -1)

(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      indent-tabs-mode nil)

(subword-mode t)

;; packages
(use-package cl-lib)
(use-package s :ensure t)
(use-package ag)
(use-package erlang)
(use-package php-mode)
(use-package dockerfile-mode)
(use-package markdown-mode)
(use-package ruby-mode)
(use-package sbt-mode)
(use-package scala-mode)
(use-package yaml-mode)
(use-package json-reformat)
(use-package go-mode)
(use-package rust-mode)
(use-package haskell-mode)
(use-package clojure-mode)
(use-package groovy-mode)
(use-package crystal-mode)
(use-package typescript-mode)
(use-package handlebars-mode)
(use-package lua-mode)
(use-package toml-mode
  :mode ("\\.toml\\'" . toml-mode))
(use-package jsonnet-mode
  :mode ("\\.libsonnet\\'" . jsonnet-mode))
(use-package zig-mode)

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
  :pin melpa-stable
  :bind (("C-x g" . magit-status)
         ("C-x G" . magit-blame)))

(use-package magit-todos)
;;(use-package magit-gh-pulls)

(use-package keyfreq
  :init (progn
          (keyfreq-mode 1)
          (keyfreq-autosave-mode 1)))

;; (use-package magithub
;;   :after magit
;;   :config (magithub-feature-autoinject t))

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

(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview))

;; uniquify
(setq uniquify-buffer-name-style 'post-forward)

;; mine/* configs
(add-to-list 'load-path "~/.emacs.d/mine")
(require 'mine-mine)
(require 'mine-ag)
(require 'mine-env)
(require 'mine-eshell)
(require 'mine-builtin)
(require 'mine-defuns)
(require 'mine-tramp)
(require 'mine-languages)
(require 'mine-mode-line)
(require 'mine-pretty)
(require 'mine-go)
(require 'mine-org)
(require 'mine-sbt)
(require 'mine-magit)
(require 'mine-rcirc)
(require 'mine-kubernetes)
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

;; joe
(defun fullscreen ()
  (interactive)
  (unless (frame-parameter (selected-frame) 'fullscreen)
    (toggle-frame-fullscreen)))

;; Normalize
(cd (getenv "HOME"))
(fullscreen)
(server-start)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-item-highlight ((t nil)))
 '(markdown-code-face ((t (:inherit fixed-pitch))))
 '(mode-line ((t (:family "Monaco" :background nil :foreground "#ff7a58" :box nil))))
 '(mode-line-buffer-id ((t :family "Monaco" :background nil :foreground "#7db5d6")))
 '(mode-line-inactive ((t (:family "Monaco" :background nil :foreground "gray" :box nil))))
 '(rcirc-keyword ((t (:foreground "#00ffff"))))
 '(rcirc-my-nick ((t (:foreground "#00ffff"))))
 '(rcirc-nick-in-message ((t (:foreground "#00ffff"))))
 '(rcirc-other-nick ((t (:foreground "#90ee90"))))
 '(rcirc-prompt ((t (:foreground "#00bfff"))))
 '(rcirc-server ((t (:foreground "#a2b5cd"))))
 '(rcirc-server-prefix ((t (:foreground "#00bfff"))))
 '(rcirc-timestamp ((t (:foreground "#7d7d7d")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(epg-gpg-program "/usr/local/bin/gpg")
 '(package-selected-packages
   '(zig-mode clojure-mode handlebars-mode typescript-mode magit-todos magit-gh-pulls lua-mode keyfreq toml-mode crystal-mode haskell-mode kubernetes jsonnet-mode magithub highlight-parentheses expand-region switch-window smex magit multiple-cursors ido-vertical-mode terraform-mode vlf groovy-mode rust-mode go-mode json-reformat yaml-mode scala-mode sbt-mode markdown-mode dockerfile-mode php-mode erlang ag s use-package)))
