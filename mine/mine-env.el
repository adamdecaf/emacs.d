;; env steup

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; shell
;; (exec-path-from-shell-initialize "PATH") ;; done automatically on osx

;; tramp
(setenv "TMPDIR" "/tmp")

;; eshell
(setenv "ESHELL" "bash")

;; docker
(setenv "DOCKER_HOST" "tcp://192.168.59.103:2376")
(exec-path-from-shell-copy-env "DOCKER_CERT_PATH")
(exec-path-from-shell-copy-env "DOCKER_TLS_VERIFY")

(provide 'mine-env)
