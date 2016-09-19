;; magit configs
(setq magit-push-always-verify nil)

;; don't revert files for me magit.
(setq magit-last-seen-setup-instructions "1.4.0")

(defun mine/kill-all-magit-buffers ()
  (interactive)
  (mine/kill-all-buffers-by-pattern "*magit"))

(provide 'mine-magit)
