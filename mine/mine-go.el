;; go-mode extensions and settings
;; see mine.el for before-save-hook

(setq godoc-command
      (if (eq system-type "darwin")
          "/usr/local/go/bin/godoc"
        "/usr/local/bin/godoc"))

;; goimports setup
(setq gofmt-command
      (if (file-exists-p "/Users/adam/go/bin/goimports")
          "/Users/adam/go/bin/goimports"
        "/Users/adam/code/bin/goimports"))

(add-hook 'before-save-hook 'gofmt-before-save)

(provide 'mine-go)
