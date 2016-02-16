;; prodigy services

;; phyom simple http server
(prodigy-define-service
  :name "Python app"
  :command "python"
  :args '("-m" "SimpleHTTPServer" "6001")
  :cwd "~/.emacs.d/mine/"
  :tags '(work)
  :kill-signal 'sigkill
  :kill-process-buffer-on-stop t)

(provide 'mine-prodigy)
