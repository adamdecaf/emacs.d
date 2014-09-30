;; common defuns
(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (let ((new-filename (concat (file-name-directory filename) new-name)))
        (progn
          (rename-file filename new-filename 1)
          (rename-buffer new-name 'unique)
          (set-visited-file-name new-filename)
          (set-buffer-modified-p nil))))))

(defun mine-sql (product sql-user sql-password sql-server sql-database root-sql-script-dir)
  (let* ((sql-text-buffer (find-file (concat root-sql-script-dir sql-database "_" sql-server ".sql")))
         (new-name (concat sql-user "@" sql-database "." sql-server))
         (sqli-buffer (if sql-buffer (progn (split-window) sql-buffer) (sql-product-interactive product new-name))))
    (switch-to-buffer sql-text-buffer nil t)
    (set (make-local-variable 'sql-buffer) sqli-buffer)
    (switch-to-buffer sqli-buffer nil t)))

(defun delete-this-file-and-buffer ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(defun ido-recentf-open ()
  "Use `ido-completing-read` to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(defun mine-tramp-cleanup ()
  (interactive)
  (tramp-cleanup-all-buffers)
  (tramp-cleanup-all-connections)
  (message "cleanup of tramp buffers/connections complete"))

(defun mine-command-line-tool (command &optional history history-symbol)
  (let* ((rest-of-command (read-from-minibuffer (concat command " ") (car history) nil nil history-symbol))
         (command-with-args (append (split-string command) (split-string rest-of-command)))
         (args (cdr command-with-args))
         (command (car command-with-args))
         (name (mapconcat 'identity command-with-args " "))
         (buffer-name (concat "*" name "*"))
         (buffer (get-buffer-create buffer-name)))
    (switch-to-buffer buffer)
    (apply 'make-comint-in-buffer name buffer command nil args)))

(provide 'mine-defuns)
