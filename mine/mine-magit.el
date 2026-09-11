(setq magit-push-always-verify nil)

;; don't show "recent commits"
(setq magit-log-section-commit-count 5)

;;(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)
;;(add-hook 'magit-mode-hook 'magit-todos-mode)

(magit-add-section-hook 'magit-status-sections-hook
                        #'magit-insert-worktrees
                        nil t)

(provide 'mine-magit)
