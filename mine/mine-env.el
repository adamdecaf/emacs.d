;; env steup
(require 's)

;; force PATH
(setenv "PATH" (concat
                "/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin/"
                ":/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9"
                ":/Applications/Emacs.app/Contents/MacOS/libexec-x86_64-10_9"
                (concat ":" (getenv "HOME") "/src/banno/banno-deploy/bin")
                (concat ":" (getenv "HOME") "/bin")
                (concat ":" (getenv "GOPATH") "/bin")))

;; (message (getenv "PATH"))

(setenv "EDITOR" "emacs")
(setenv "JAVA_HOME" "/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home")
(setenv "TMPDIR" "/tmp") ;; tramp
(setenv "TZ" "America/Chicago")

;; Misc
(setenv "GOPATH" "/Users/adam/code")
(setenv "JAVA_HOME" (shell-command-to-string "/usr/libexec/java_home"))
(setenv "TF_PLUGIN_CACHE_DIR" (concat (getenv "HOME") "/.terraform.d/plugin-cache"))

;; kubernetes
(setenv "KUBECONFIG" (let ((home (getenv "HOME")))
                       (concat
                        (concat home "/.kube/config:")
                        (concat home "/.kube/kube-config-k8s-banno-staging:")
                        (concat home "/.kube/kube-config-k8s-banno-uat:")
                        (concat home "/.kube/kube-config-k8s-banno-production"))))

(provide 'mine-env)
