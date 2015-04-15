;; mine-magit.el

(defun switch-to-magit-process()
  (interactive)
  (switch-to-buffer "*magit-process*"))

(defun get-remote-name(&optional maybe-remote-name)
  (if (not maybe-remote-name) "origin" maybe-remote-name))

;; todo: How does magit get the current directory?
;; Or is there a magit-shell-command method or something we can use?
(defun magit/git-remote-show-origin(&optional maybe-remote-name)
  (interactive)
  (let* ((remote-name (get-remote-name maybe-remote-name))
         (last-dir default-directory))
    (cd default-directory)
    (async-shell-command (concat "git remote show " remote-name))
    (cd last-dir)))

(provide 'mine-magit)
