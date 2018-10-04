;; common things to mine-*.el files

(setq before-save-hook
      '(lambda ()
         ;; trim all files
         (if mine/delete-trailing-whitespace
             (delete-trailing-whitespace))

         ;; go-mode
         ;; (if (string-match-p "go-mode" (format "%s" major-mode))
         ;;                     (lambda ()
         ;;                       (message "foo")
         ;;                       (gofmt-before-save)
         ;;                       (go-remove-unused-imports)))

         ;; make parent dirs
         (if buffer-file-name
             (progn
               (let
                   ((dir
                     (file-name-directory buffer-file-name)))
                 (if
                     (and
                      (not
                       (file-exists-p dir))
                      (y-or-n-p
                       (format "Directory %s does not exist. Create it?" dir)))
                     (progn
                       (make-directory dir t))))))))

(provide 'mine-mine)
