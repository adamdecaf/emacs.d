;; env steup
(require 's)

;; force PATH
(setenv "PATH" (concat
                "/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin"
                ;; ":/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9"
                ;; ":/Applications/Emacs.app/Contents/MacOS/libexec-x86_64-10_9"
                (concat ":" (getenv "HOME") "/src/banno/banno-deploy/bin")
                (concat ":" (getenv "HOME") "/bin")
                (concat ":" (getenv "GOPATH") "/bin")))

;; (message (getenv "PATH"))

(setenv "EDITOR" "emacs")
(setenv "JAVA_HOME" "/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home")
(setenv "TMPDIR" "/tmp") ;; tramp
(setenv "TZ" "America/Chicago")

(provide 'mine-env)
