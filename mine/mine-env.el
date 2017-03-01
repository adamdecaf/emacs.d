;; env steup
(require 's)

(defun mine/set-emacs-env-variable (name value)
  (if (s-blank? (getenv name))
      (setenv name value)))

(defun mine/update-path (incoming)
  (if (not (s-contains? (getenv "PATH") incoming))
      (setenv (concat (getenv "PATH") ":" incoming))))

;; golang
(if (eq system-type 'gnu/linux)
    (setq gopath "/home/adam/src/go"))
(if (eq system-type 'darwin)
    (setq gopath "/Users/adam/src/go"))
(mine/set-emacs-env-variable "GOPATH" gopath)
(mine/update-path (concat gopath "/bin"))

;; force path
(when (not (string-match "local" (getenv "PATH")))
  (setenv "PATH" (concat (getenv "PATH")
                         ":/usr/local/bin:/usr/local/sbin")))

(setenv "EDITOR" "emacs")
(setenv "JAVA_HOME" "/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home")
(setenv "TMPDIR" "/tmp") ;; tramp
(setenv "TZ" "America/Chicago")

;; docker
(setenv "DOCKER_TLS_VERIFY" "1")
(setenv "DOCKER_HOST" "tcp://192.168.99.100:2376")
(setenv "DOCKER_CERT_PATH" "/Users/adam/.docker/machine/machines/banno-big")
(setenv "DOCKER_MACHINE_NAME" "banno-big")

(provide 'mine-env)
