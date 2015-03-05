(setq max-lisp-eval-depth 10000) ;; scary stuff

;; ido-mode
(require 'ido)
(ido-everywhere t)
(setq ido-default-file-method 'selected-window
      ido-default-buffer-method 'selected-window)

;; ido setup
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-max-prospects 10
      ido-show-dot-for-dired nil)

;; tramp remote sudo
;; (set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

(require 'recentf)
(recentf-mode t)
(setq recentf-max-saved-items 50)

;; Setup Environmental Variables
(setq default-major-mode 'text-mode)
(setq inhibit-startup-message t)

;; Auto revert files
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode t)

;; Buffer selection setup
(setq bs-configurations
      '(("all" nil nil nil nil nil)
        ("files" nil nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)
        ("rcirc" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (not (eq major-mode 'rcirc-mode)))) nil)
        ("dired" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (not (eq major-mode 'dired-mode)))) nil)
        ("eshell" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (not (eq major-mode 'eshell-mode)))) nil)
        ("magit" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (not (eq major-mode 'magit-mode)))) nil)
        ("sbt" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (not (string-prefix-p "*sbt:" (buffer-name buf))))) nil)
        ("sql" nil nil nil
         (lambda (buf)
           (with-current-buffer buf
             (and
              (not (eq major-mode 'sql-mode))
              (not (eq major-mode 'sql-interactive-mode))))) nil)))

(setq bs-mode-font-lock-keywords
      (list
                                        ; Headers
       (list "^[ ]+\\([-M].*\\)$" 1 font-lock-keyword-face)
                                        ; Boring buffers
       (list "^\\(.*\\*.*\\*.*\\)$" 1 font-lock-comment-face)
                                        ; Dired buffers
       '("^[ .*%]+\\(Dired.*\\)$" 1 font-lock-type-face)
                                        ; Modified buffers
       '("^[ .]+\\(\\*\\)" 1 font-lock-warning-face)
                                        ; Read-only buffers
       '("^[ .*]+\\(\\%\\)" 1 font-lock-variable-name-face)))

;; Create non-existent directories containing a new file before saving
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))

;; Use soft tabs
(setq-default indent-tabs-mode nil)

;; Allow to be able to select text and start typing or delete
(delete-selection-mode t)

;; delete trailing whitespace on save
(setq mine-delete-trailing-whitespace t)
(defun mine-leave-whitespace-in-buffer ()
  (interactive)
  (make-variable-buffer-local 'mine-leave-whitespace)
  (setq mine-delete-trailing-whitespace nil))
(add-hook 'before-save-hook '(lambda () (if mine-delete-trailing-whitespace (delete-trailing-whitespace))))

;; dired things
(add-hook 'dired-mode-hook '(lambda ()
                              (local-set-key (kbd "C-c R") 'wdired-change-to-wdired-mode)))
(setq wdired-allow-to-change-permissions "advanced")
(setq wdired-confirm-overwrite t)
(setq wdired-use-dired-vertical-movement t)
(defalias 'wdired 'wdired-change-to-wdired-mode)

(add-hook 'emacs-lisp-mode-hook '(lambda () (eldoc-mode t)))

;; Miscallaneous Things
(if (fboundp 'mouse-wheel-mode) (mouse-wheel-mode t))
(setq x-select-enable-clipboard t)

;; Backups
(setq version-control nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

(toggle-case-fold-search)

;; mac os x specific
(progn ()
       (setq ns-command-modifier 'meta)
       (setq interprogram-paste-function 'x-selection-value)
       (setq browse-url-browser-function 'browse-url-default-macosx-browser)
       (setq ack-executable "ack")
       )

(setq vc-follow-symlinks t)

(provide 'mine-builtin)
