;; env steup
(require 's)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(defun mine-set-emacs-env-variable (name value)
  (if (s-blank? (getenv name))
      (setenv name value)))

(defun mine-update-path (incoming)
  (if (not (s-contains? (getenv "PATH") incoming))
      (setenv (concat (getenv "PATH") ":" incoming))))

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

;; go
(mine-set-emacs-env-variable "GOPATH" "/Users/adam/src/go")
(mine-update-path (concat (getenv "GOPATH") "/bin"))

(defun mine-show-docker-env-variables()
  (interactive)
  (message (concat "DOCKER_HOST" (getenv "DOCKER_HOST")))
  (message (concat "DOCKER_CERT_PATH" (getenv "DOCKER_CERT_PATH")))
  (message (concat "DOCKER_TLS_VERIFY" (getenv "DOCKER_TLS_VERIFY"))))

(defun mine-echo-aws-creds()
  (interactive)
  (message (getenv "AWS_ACCESS_KEY_ID"))
  (message (concat "aws creds in use: " whose-aws-creds-are-in-use)))

(defun mine-echo-path()
  (interactive)
  (message (getenv "PATH")))

(provide 'mine-env)
