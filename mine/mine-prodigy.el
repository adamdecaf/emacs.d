;; prodigy services

(defun mine/prodigy-clear-services()
  (interactive)
  (setq prodigy-services nil))

;; python simple http server
(prodigy-define-service
  :name "web server @ directory"
  :command "python"
  :args '("-m" "SimpleHTTPServer" "6001")
  :cwd "~/.emacs.d/mine/"
  :tags '(mine)
  :kill-signal 'sigkill)

(provide 'mine-prodigy)
