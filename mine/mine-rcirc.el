;; rcirc configs
(require 'rcirc)

(setq rcirc-default-nick "adamdecaf")
(setq rcirc-default-user-name "adamdecaf")
(setq rcirc-default-full-name "Adam Shannon")

(custom-set-faces
 '(rcirc-my-nick ((t (:foreground "#00ffff"))))
 '(rcirc-other-nick ((t (:foreground "#90ee90"))))
 '(rcirc-server ((t (:foreground "#a2b5cd"))))
 '(rcirc-server-prefix ((t (:foreground "#00bfff"))))
 '(rcirc-timestamp ((t (:foreground "#7d7d7d"))))
 '(rcirc-nick-in-message ((t (:foreground "#00ffff"))))
 '(rcirc-prompt ((t (:foreground "#00bfff")))))

(defun mine/rcirc-connect()
  (interactive)
  (if (not (boundp 'znc-pass))
      (error "Not connecting to znc as znc-pass is not set!"))

  ;; rcirc-server-alist is read from ~/.emacs.d/hidden.el
  (if (or (not (boundp 'rcirc-server-alist))
          (not rcirc-server-alist))
      (error "rcirc-server-alist is not specified"))

  ;; Connect!
  (rcirc nil))

(setq debug-on-message "Selecting deleted buffer")

;; detach from all buffers
(defun mine/rcirc-detach(buf)
  (with-current-buffer buf
    (if (and (process-live-p (get-buffer-process buf))
             (string-suffix-p ".znc.decaf.zone*" (buffer-name buf)))
        (rcirc-detach-buffer))))

(defun mine/get-sorted-buffers()
  (sort
   (mapcar 'buffer-name (buffer-list))
   'string-lessp))

;; todo: try just iterating over rcirc-server-alist and getting server name -> buffer name
;; use get-buffer to see if it's there and check if a process is running
(defun mine/rcirc-detach-all()
  (interactive)
  (let* ((sorted (mine/get-sorted-buffers)))
    (dolist (buf sorted)
      (mine/rcirc-detach (get-buffer buf)))))

;; From https://superuser.com/questions/249563/using-rcirc-with-a-irc-bouncer-like-znc
(defun rcirc-detach-buffer ()
  (interactive)
  (let ((buffer (current-buffer)))
    (when (and (rcirc-buffer-process)
               (eq (process-status (rcirc-buffer-process)) 'open))
      (with-rcirc-server-buffer
        (setq rcirc-buffer-alist
              (rassq-delete-all buffer rcirc-buffer-alist)))
      (rcirc-update-short-buffer-names)
      (if (rcirc-channel-p rcirc-target)
          (rcirc-send-string (rcirc-buffer-process)
                             (concat "DETACH " rcirc-target))))
    (setq rcirc-target nil)
    (kill-buffer buffer)))

;; swallow annoying KEEPALIVE messages with a sledgehammer
(defun rcirc-handler-NOTICE (process sender args text))

;; Set some rcirc configs
(setq rcirc-notify-message "%s: %s"
      rcirc-buffer-maximum-lines 2000)

(setq rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY" "MODE"))

(setq rcirc-keywords '("adam" "adamdecaf" ;; Personal
                       "@ds-design" "@infrastructure" ;; Banno
                       ))

(defun mine/rcirc-next-active-buffer-bury-rcirc-buffers (arg)
  "Switch to the next rcirc buffer with activity, burying all rcirc buffers after returning to a non-rcirc buffer.
With prefix ARG, go to the next low priority buffer with activity."
  (interactive "P")
  (rcirc-next-active-buffer arg)
  (unless (eq major-mode 'rcirc-mode)
    (mine/rcirc-bury-buffers)))

(defun mine/rcirc-talk-to-me()
  (interactive)
  (rcirc-track-minor-mode 1))

(defun mine/rcirc-shut-up ()
  (interactive)
  (rcirc-track-minor-mode -1))

;; nice trick to make rcirc windows bigger
(add-hook 'window-configuration-change-hook
          '(lambda ()
             (setq rcirc-fill-column (- (window-width) 2))))

(mine/rcirc-talk-to-me)

(defun mine/browse-irc-logs()
  (interactive)
  (find-file "/sshx:znc0.decaf.zone:/opt/znc/moddata/log/adam"))

(provide 'mine-rcirc)
