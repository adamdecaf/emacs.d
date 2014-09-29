;; emacs setup
(setq debug-on-error t)

(server-start)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      indent-tabs-mode nil)

(push "/usr/local/bin" exec-path)

;; setup use-package
(push "~/.emacs.d/use-package/" load-path)

(require 'package)
(require 'use-package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)
(package-refresh-contents)

;; theme
(load-theme 'wombat t)

;; packages
(use-package ag :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package markdown-mode :ensure t)
(use-package projectile :ensure t)
(use-package ruby-mode :ensure t)
(use-package sbt-mode :ensure t)
(use-package scala-mode2 :ensure t)
(use-package yaml-mode :ensure t)

(use-package magit
  :bind ("C-x g" . magit-status)
  :ensure t)

(use-package smex
  :bind (("M-x" . smex))
  :ensure t)

(use-package switch-window
  :bind ("C-x o" . switch-window)
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
;; (require 'mine-smartparens)
;;   - (require 'smartparens-config)
;;   - (provide 'mine-smartparens)
;;   - (smartparens-global-strict-mode t)

;; language / tool specifics
(require 'mine-sbt)

;; (require 'mine-banno-ids)
;; (require 'mine-banno-servers)
;; (require 'mine-banno-misc)

;; (require 'mine-my-servers)
;; (require 'mine-personal-servers)

(setq mine-custom-dir "~/.emacs.d/custom/")
(if (file-exists-p mine-custom-dir)
 (let ((custom-files (directory-files mine-custom-dir t "\.el$")))
  (mapcar 'load-file custom-files)))

(setq custom-file (expand-file-name "~/.emacs.d/customizations.el"))
(load custom-file)


(put 'dired-find-alternate-file 'disabled nil)
(put 'ido-exit-minibuffer 'disabled nil)
