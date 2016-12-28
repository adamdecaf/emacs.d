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
  (if (get-buffer-process "*znc0.decaf.zone*")
      (error "Already connected to rcirc"))
  (if (not (boundp 'znc-pass))
      (error "Not connecting to znc as znc-pass is not set!"))

  (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adamdecaf" "adam" '() (concat "adam/freenode:" znc-pass) 'tls)
  (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adam" "adam" '() (concat "adam/banno:" znc-pass) 'tls)
  (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adam" "adam" '() (concat "adam/unifreethought:" znc-pass) 'tls)
  (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adamdecaf" "adam" '() (concat "adam/oftc:" znc-pass) 'tls)
  (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adam" "adam" '() (concat "adam/snoonet:" znc-pass) 'tls)
  (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adam" "adam" '() (concat "adam/indymedia:" znc-pass) 'tls)
  (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adam" "adam" '() (concat "adam/mozilla:" znc-pass) 'tls)
  (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adam" "adam" '() (concat "adam/efnet:" znc-pass) 'tls)

  ;; (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adam" "adam" '() (concat "adam/soylent:" znc-pass) 'tls) ;; spammy

  ;; todo: https://irc.gitter.im/

  ;; Bad SSL certs
  ;; (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adamdecaf" "adam" '() (concat "adam/netfuze:" znc-pass) 'tls)
  ;; (rcirc-connect "znc0.decaf.zone" 6697 "adam" "adamdecaf" "adam" '() (concat "adam/ferwy:" znc-pass) 'tls)

  ;; Checkout these networks
  ;; encom
  ;; ramen
  ;; cfl
  ;; slashnet
  ;; oftc -- more channels?
  )

(defun mine/rcirc-detach-all()
  (interactive)
  (dolist (buffer (buffer-list))
    (if (string-prefix-p "*znc" (buffer-name buffer))
        (progn
          (switch-to-buffer buffer)
          (rcirc-detach-buffer)))))

(defun mine/rcirc-ignore-slack-keepalive(buf-name)
  (let* (buf (current-buffer))
    (switch-to-buffer buf-name)
    (if (and (not (boundp 'rcirc-ignore-channel-activity))
             (not 'rcirc-ignore-channel-activity))
        (rcirc-toggle-ignore-buffer-activity))
    (switch-to-buffer buf)))

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
(define-key rcirc-mode-map [(control c) (control d)] 'rcirc-detach-buffer)

;; nice trick to make rcirc windows bigger
(add-hook 'window-configuration-change-hook
          '(lambda ()
             (setq rcirc-fill-column (- (window-width) 2))))

(mine/rcirc-talk-to-me)

(provide 'mine-rcirc)
