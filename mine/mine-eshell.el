
(setq eshell-path-env (string-join
                       '(
                         "/usr/bin"
                         "/bin"
                         "/usr/sbin"
                         "/sbin"
                         "/usr/local/bin/"
                         "/home/adam/bin"
                         "/home/adam/code/bin"
                         "/usr/local/go/bin/")
                       ":"))

(provide 'mine-eshell)
