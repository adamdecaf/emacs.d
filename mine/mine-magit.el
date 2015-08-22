(require 'magit-gh-pulls)

(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)
(setq magit-push-always-verify nil)

(provide 'mine-magit)
