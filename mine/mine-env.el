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
(setenv "EDITOR" "emacsclient")

;; eshell
(setenv "ESHELL" "bash")

;; docker
(setenv "DOCKER_HOST" "tcp://192.168.59.103:2376")

(defun mine-copy-env-variable (name)
  (if (getenv name)
      (exec-path-from-shell-copy-env name)))

(mine-copy-env-variable "DOCKER_CERT_PATH")
(mine-copy-env-variable "DOCKER_TLS_VERIFY")

(defun mine-echo-aws-creds()
  (interactive)
  (message (getenv "AWS_ACCESS_KEY_ID"))
  (message (concat "aws creds in use: " whose-aws-creds-are-in-use)))

(provide 'mine-env)
