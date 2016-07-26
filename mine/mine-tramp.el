(require 'tramp)

(defun mine/tramp-cleanup-connections-and-buffers ()
  (interactive)
  (tramp-cleanup-all-buffers)
  (tramp-cleanup-all-connections)
  (message "cleanup of tramp buffers/connections complete"))

(provide 'mine-tramp)
