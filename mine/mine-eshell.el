;; eshell setup
(require 's)

(setq eshell-path-env mine-path)
(setq eshell-buffer-shorthand t)

;; helpful defuns
(defun mine/kill-all-eshell-buffers ()
  (interactive)
  (mine/kill-all-buffers-by-pattern "*eshell*"))

;; eshell buffer name
;; inspired / initially copied from rubbish
(defun mine/eshell-rename-buffer-pwd (&optional name)
  (let* ((pwd (eshell/pwd))
         (full-name (concat "*eshell " "<" pwd ">* name: " name)))
    (rename-buffer full-name t)))

(add-hook 'eshell-directory-change-hook 'mine/eshell-rename-buffer-pwd)

;; Force PATH in each buffer
(defun mine/eshell-mode-hook ()
  (setq eshell-path-env mine-path))
(add-hook 'eshell-mode-hook #'mine/eshell-mode-hook)

;; find / create eshells
;; from rubbish
(defun mine/eshell-buffer-p (buffer)
  (and (eq 'eshell-mode (buffer-local-value 'major-mode buffer))
       buffer))

(defun mine/get-eshell-buffers ()
  (delq nil (mapcar 'mine/eshell-buffer-p (buffer-list))))

(defun mine/eshell-create (&optional name)
  (interactive)
  (eshell t)
  (mine/eshell-rename-buffer-pwd name))

(defun mine/eshell-find-best-match (dir)
  (let ((pwd (expand-file-name dir))
        (best-match-buffer nil))
    (dolist (b (mine/get-eshell-buffers) best-match-buffer)
      (let* ((b-pwd       (with-current-buffer b (expand-file-name ".")))
             (b-match     (string-match b-pwd pwd))
             (b-match-end (and b-match (match-end 0)))
             (best-match-pwd (and best-match-buffer (with-current-buffer best-match-buffer (expand-file-name "."))))
             (best-match     (and best-match-buffer (string-match best-match-pwd pwd)))
             (best-match-end (and best-match-buffer (and best-match (match-end 0)))))
        (if (or (and (eq nil best-match-end)
                     b-match-end)
                (and b-match-end
                     (> b-match-end best-match-end)))
            (setq best-match-buffer b))))))

(defun mine/eshell-find-by-name (name)
  (let ((best-match-buffer nil))
    (dolist (b (mine/get-eshell-buffers) best-match-buffer)
      (if (s-contains? name (buffer-name b))
          (setq best-match-buffer b)))))

(defun mine/eshell-switch-to-closest-or-create-here ()
  (interactive)
  (let ((best-match-buffer (mine/eshell-find-best-match default-directory)))
    (if best-match-buffer
        (switch-to-buffer best-match-buffer)
      (mine/eshell-create))))

(defun mine/eshell-switch-to-closest-or-create-by-name (name)
  (let ((best-match-buffer (mine/eshell-find-by-name name)))
    (if best-match-buffer
        (switch-to-buffer best-match-buffer)
        (mine/eshell-create name))))

;; custom eshell search history command
(defvar eshell-name-history nil)
(defun mine/eshell-pick-and-choose ()
  (interactive)
  (let ((needle (read-from-minibuffer "eshell name: " (car eshell-name-history) nil nil 'eshell-name-history)))
    (mine/eshell-switch-to-closest-or-create-by-name needle)))

(provide 'mine-eshell)
