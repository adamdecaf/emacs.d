;; common defuns
(defun mine/indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

;; rubbish
(defun mine/beginning-of-line-or-back-to-indention ()
  (interactive)
  "This goes to back to indention or if already there beginning of line"
  (let ((previous-point (point)))
    (back-to-indentation)
    (if (equal previous-point (point))
	(beginning-of-line))))

;; make scratch buffer
(defun mine/scratch()
  (interactive)
  (switch-to-buffer
   (get-buffer-create "*scratch*")))

;; date/time
(defun mine/insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun mine/insert-iso-timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%dT%H:%M:%S")))

(defun mine/insert-todo ()
  (interactive)
  (move-end-of-line nil)
  (insert " // TODO(adam): ")
  (move-end-of-line nil))

(defun mine/message-the-time()
  (interactive)
  (message (string-trim (shell-command-to-string "date"))))

;; joe
(defun mine/rename-file-and-buffer (new-name)
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
(defun mine/sql (product sql-user sql-password sql-server sql-database root-sql-script-dir &optional interactive-mode)
  (let* ((sql-text-buffer (find-file (concat root-sql-script-dir sql-database "_" sql-server ".sql")))
         (new-name (concat sql-user "@" sql-database "." sql-server))
         (sqli-buffer (if sql-buffer (progn (split-window) sql-buffer) (sql-product-interactive product new-name))))
    (switch-to-buffer sql-text-buffer nil t)
    (set (make-local-variable 'sql-buffer) sqli-buffer)
    (switch-to-buffer sqli-buffer nil t)
    (if interactive-mode
        (sql-send-string "\\x"))))

;; joe
(defun mine/delete-this-file-and-buffer ()
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
(defun mine/swap-windows ()
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
(defun mine/toggle-window-split ()
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
(defun mine/command-line-tool (command &optional history history-symbol)
  (let* ((rest-of-command (read-from-minibuffer (concat command " ") (car history) nil nil history-symbol))
         (command-with-args (append (split-string command) (split-string rest-of-command)))
         (args (cdr command-with-args))
         (command (car command-with-args))
         (name (mapconcat 'identity command-with-args " "))
         (buffer-name (concat "*" name "*"))
         (buffer (get-buffer-create buffer-name)))
    (switch-to-buffer buffer)
    (apply 'make-comint-in-buffer name buffer command nil args)))

(defun mine/async-shell-command (cmd)
  (interactive)
  (let* ((process-name (concat cmd " <localhost>"))
         (program (car (split-string cmd)))
         (args (cdr (split-string cmd)))
         (buffer-name (format "*%s*" process-name))
         (buffer (get-buffer-create buffer-name)))
    (apply 'make-comint-in-buffer process-name buffer program nil args)
    (switch-to-buffer buffer)))

;; joe
(defun mine/ssh-tunnel-ask ()
  (interactive)
  (let* ((host (read-string "Host: "))
         (command (read-string "Command: "))
         (ssh-username (read-string "Username: " (getenv "USER"))))
    (mine/ssh-tunnel-cmd host command ssh-username)))

;; joe
(defun mine/ssh-tunnel-cmd (host command &optional ssh-username)
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

;; pretty print xml
(defun mine/xml-pretty-print-region ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "xmllint --format -" nil t))

;; rubbish
(defun mine/insert-random-uuid ()
  (interactive)
  (shell-command "uuidgen | tr -d '\n' | tr '[A-Z]' '[a-z]'" t))

(defun mine/ssh-workstation()
  (interactive)
  (find-file "/sshx:znc0.decaf.zone:/root"))

(provide 'mine-defuns)
