;; env steup
(require 's)

(defun mine/set-emacs-env-variable (name value)
  (if (s-blank? (getenv name))
      (setenv name value)))

(defun mine/update-path (incoming)
  (if (not (s-contains? (getenv "PATH") incoming))
      (setenv (concat (getenv "PATH") ":" incoming))))

;; golang
(setq gopath "/Users/adam/src/go")
(mine/set-emacs-env-variable "GOPATH" gopath)
(mine/update-path (concat gopath "/bin"))

;; force path
(setq ruby-path "/Users/adam/.rvm/rubies/default/bin:/Users/adam/.rvm/gems/ruby-2.3.1/bin:$HOME/.rvm/bin")
(setq go-path (concat gopath "/bin"))
(setenv "PATH" (concat ruby-path ":/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:$BANNO_DEPLOY_DIR/bin:/Users/adam/bin:/Users/adam/node_modules/.bin:" go-path))

;; exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setenv "EDITOR" "emacs")
(setenv "ESHELL" "bash")
(setenv "JAVA_HOME" "/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home")
(setenv "TMPDIR" "/tmp") ;; tramp
(setenv "TZ" "America/Chicago")

;; docker
(setenv "DOCKER_TLS_VERIFY" "1")
(setenv "DOCKER_HOST" "tcp://192.168.99.100:2376")
(setenv "DOCKER_CERT_PATH" "/Users/adam/.docker/machine/machines/banno-big")
(setenv "DOCKER_MACHINE_NAME" "banno-big")

(defun mine/show-docker-env-variables()
  (interactive)
  (message (concat "DOCKER_HOST" (getenv "DOCKER_HOST")))
  (message (concat "DOCKER_CERT_PATH" (getenv "DOCKER_CERT_PATH")))
  (message (concat "DOCKER_TLS_VERIFY" (getenv "DOCKER_TLS_VERIFY"))))

(defun mine/echo-aws-creds()
  (interactive)
  (message (getenv "AWS_ACCESS_KEY_ID"))
  (message (concat "aws creds in use: " whose-aws-creds-are-in-use)))

(defun mine/echo-path()
  (interactive)
  (message (getenv "PATH")))

(provide 'mine-env)
