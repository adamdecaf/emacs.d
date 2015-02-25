;; env steup

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; shell
;; (exec-path-from-shell-initialize "PATH") ;; done automatically on osx

;; time
(setenv "TZ" "America/Chicago")

;; tramp
(setenv "TMPDIR" "/tmp")

;; editor
(setenv "EDITOR" "emacs")

;; eshell
(setenv "ESHELL" "bash")

;; docker
(setenv "DOCKER_HOST" "tcp://192.168.59.103:2376")
(setenv "DOCKER_CERT_PATH" "/Users/adam/.boot2docker/certs/boot2docker-vm")
(setenv "DOCKER_TLS_VERIFY" "1")

(defun mine-show-docker-env-variables()
  (interactive)
  (message (concat "DOCKER_HOST" (getenv "DOCKER_HOST")))
  (message (concat "DOCKER_CERT_PATH" (getenv "DOCKER_CERT_PATH")))
  (message (concat "DOCKER_TLS_VERIFY" (getenv "DOCKER_TLS_VERIFY"))))

(defun mine-echo-aws-creds()
  (interactive)
  (message (getenv "AWS_ACCESS_KEY_ID"))
  (message (concat "aws creds in use: " whose-aws-creds-are-in-use)))

(provide 'mine-env)
