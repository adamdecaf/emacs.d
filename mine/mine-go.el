;; go-mode extensions and settings
;; see mine.el for before-save-hook

(setq godoc-command
      (if (eq system-type "darwin")
          "/usr/local/go/bin/godoc"
        "/usr/local/bin/godoc"))

(provide 'mine-go)
