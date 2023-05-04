;; env steup
(require 's)

(setq mine-path (string-join
                 '(
                   "/usr/local/bin"
                   "/usr/bin"
                   "/bin"
                   "/usr/sbin"
                   "/sbin"
                   "/Users/adam/code/bin"
                   "/Users/adam/bin"
                   "/opt/homebrew/bin/"
                   )
                 ":"))

;; force PATH
(setenv "PATH" (concat
                mine-path
                ":/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9"
                ":/Applications/Emacs.app/Contents/MacOS/libexec-x86_64-10_9"
                ))

(setenv "EDITOR" "emacs")
(setenv "ESHELL" "bash")
(setenv "TZ" "America/Chicago")

(setenv "GOPATH" "/Users/adam/code/")
(setenv "GOPRIVATE" "github.com/moov-io/*,github.com/moovfinancial/*")

;; kubernetes
(setenv "KUBECONFIG" (let ((home (getenv "HOME")))
                       (concat
                        (concat home "/.kube/config:"))))

(provide 'mine-env)
