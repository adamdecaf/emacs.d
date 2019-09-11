(setq magit-push-always-verify nil)

;; don't show "recent commits"
(setq magit-log-section-commit-count 5)

(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)

(provide 'mine-magit)
