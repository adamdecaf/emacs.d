;; common defuns
(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

;; date/time
(defun insert-date ()
  (interactive)
  (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

(defun insert-iso-timestamp ()
  (interactive)
  (insert (shell-command-to-string "echo -n $(date -u +%Y-%m-%dT%H:%M:%SZ)")))

(defun mine-message-the-time()
  (interactive)
  (message (shell-command-to-string "echo -n $(date -u +%Y-%m-%dT%H:%M:%SZ)")))

;; joe
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

;; joe
(defun mine-sql (product sql-user sql-password sql-server sql-database root-sql-script-dir)
  (let* ((sql-text-buffer (find-file (concat root-sql-script-dir sql-database "_" sql-server ".sql")))
         (new-name (concat sql-user "@" sql-database "." sql-server))
         (sqli-buffer (if sql-buffer (progn (split-window) sql-buffer) (sql-product-interactive product new-name))))
    (switch-to-buffer sql-text-buffer nil t)
    (set (make-local-variable 'sql-buffer) sqli-buffer)
    (switch-to-buffer sqli-buffer nil t)))

;; joe
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

;; rubbish
(defun swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (cond ((/= (count-windows) 2)
         (message "You need exactly 2 windows to do this."))
        (t
         (let* ((w1 (first (window-list)))
                (w2 (second (window-list)))
                (b1 (window-buffer w1))
                (b2 (window-buffer w2))
                (s1 (window-start w1))
                (s2 (window-start w2)))
           (set-window-buffer w1 b2)
           (set-window-buffer w2 b1)
           (set-window-start w1 s2)
           (set-window-start w2 s1))))
  (other-window 1))

;; rubbish
(defun toggle-window-split ()
  "Vertical split shows more of each line, horizontal split shows
more lines. This code toggles between them. It only works for
frames with exactly two windows."
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

;; rubbish
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

;; rubbish
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

;; todo
;; (command-with-args (append (split-string command) (split-string rest-of-command)))
(defun async-shell-command (cmd)
  (interactive)
  (let* ((process-name (concat cmd " <localhost>"))
         (buffer-name (format "*%s*" process-name))
         (buffer (get-buffer-create buffer-name)))
    (apply 'make-comint-in-buffer process-name buffer cmd nil args)
    (switch-to-buffer buffer)))

;; joe
(defun ssh-tunnel-ask ()
  (interactive)
  (let* ((host (read-string "Host: "))
         (command (read-string "Command: "))
         (ssh-username (read-string "Username: " (getenv "USER"))))
    (ssh-tunnel-cmd host command ssh-username)
    ))

;; joe
(defun ssh-tunnel-cmd (host command &optional ssh-username)
  (require 'comint)
  (let* ((process-name (format "%s <%s>" command host))
         (buffer-name (format "*%s*" process-name))
         (buffer (get-buffer-create buffer-name))
         (login (if ssh-username
                    (concat ssh-username "@" host)
                  host))
         (tunnel-args (list "-t" login command)))
    (apply 'make-comint-in-buffer process-name buffer "ssh" nil tunnel-args)
    (switch-to-buffer buffer)))

;; inspired from rubbish
(defun mine-kill-all-buffers-by-pattern (pattern)
  (dolist (buffer (buffer-list))
    (if (string-match pattern (buffer-name buffer))
        (kill-buffer buffer))))

(defun mine-kill-all-log-buffers ()
  (interactive)
  (mine-kill-all-buffers-by-pattern ".+\\.log:?"))

(defun mine-kill-all-ag-search-buffers ()
  (interactive)
  (mine-kill-all-buffers-by-pattern "*ag search.+"))

;; rubbish
(defun insert-random-uuid ()
  (interactive)
  (shell-command "uuidgen | tr -d '\n' | tr '[A-Z]' '[a-z]'" t))

;; ssh into any random server
(defvar last-hostname-used nil)
(defun ssh-into-server ()
  (interactive)
  (let* ((hostname (read-from-minibuffer "Hostname: " (car last-hostname-used) nil nil 'last-hostname-used)))
    (find-file (concat "/scp:" hostname ":/home/adam/.bashrc"))))

;; curl wrappers
(defvar curl-from-localhost-history nil)
(defvar curl-last-verb-used (list "GET"))
(defun mine-curl-from-localhost ()
  (interactive)
  (let* ((verb (read-from-minibuffer "Verb: " (car curl-last-verb-used) nil nil 'curl-last-verb-used))
        (command (format "curl -v -X %s" verb)))
    (mine-command-line-tool command curl-from-localhost-history 'curl-from-localhost-history)))

(provide 'mine-defuns)
