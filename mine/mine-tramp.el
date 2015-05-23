(require 'tramp)

(defun mine/tramp-cleanup ()
  (interactive)
  (tramp-cleanup-all-buffers)
  (tramp-cleanup-all-connections)
  (message "cleanup of tramp buffers/connections complete"))

;; From: http://www.emacswiki.org/emacs/TrampAndDocker
;; Open files in Docker containers like so: /docker:drunk_bardeen:/etc/passwd
(push (cons "docker" '((tramp-login-program "docker")
                       (tramp-login-args (("exec" "-it") ("%h") ("/bin/bash")))
                       (tramp-remote-shell "/bin/sh")
                       (tramp-remote-shell-args ("-i") ("-c"))))
      tramp-methods)

(defadvice tramp-completion-handle-file-name-all-completions
  (around dotemacs-completion-docker activate)
  "(tramp-completion-handle-file-name-all-completions \"\" \"/docker:\" returns
    a list of active Docker container names, followed by colons."
  (if (equal (ad-get-arg 1) "/docker:")
      (let* ((dockernames-raw
              (shell-command-to-string "docker ps | perl -we 'use strict; $_ = <>; m/^(.*)NAMES/ or die; my $offset = length($1); while(<>) {substr($_, 0, $offset, q()); chomp; for(split m/\\W+/) {print qq($_:\n)} }'"))
             (dockernames (cl-remove-if-not #'(lambda (dockerline) (string-match ":$" dockerline))
                                            (split-string dockernames-raw "\n"))))
        (setq ad-return-value dockernames))
    ad-do-it))

;; Show local images
(defun mine/list-local-images()
  (interactive)
  (shell-command-to-string "docker ps | grep -v IMAGE"))

;; Enter a local image
(defun mine/enter-local-docker-image-logs()
  (interactive)
  (let* ((running-images (tramp/list-local-images))
         (prompt (concat running-images "\nImage name: "))
         (image-name (read-from-minibuffer prompt)))
    (find-file (concat "/docker:" image-name ":/var/log/"))))

(provide 'mine-tramp)
