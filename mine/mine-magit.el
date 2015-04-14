;; mine-magit.el

(defun switch-to-magit-process()
  (interactive)
  (switch-to-buffer "*magit-process*"))

(defun magit/git-remote-show-origin(&optional maybe-remote-name)
  (interactive)
  (let ((remote-name (if (not maybe-remote-name)
                         "origin"
                       maybe-remote-name)))
    (async-shell-command (concat "git remote show " remote-name))))

(provide 'mine-magit)
