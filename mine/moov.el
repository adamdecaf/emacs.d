;; moov.io emacs commands

(setq moov/kubectl-path kubernetes-kubectl-executable) ;; from mine-kubernetes.el
;; (setq moov/kubectl-path (string-trim (shell-command-to-string "/usr/bin/which -a kubectl | head -n1")))

;; kubectl logs deployment/traefik-beta -n lb -c traefik | grep 'moov.io/demo' | grep -v ' 200 '
(defun moov/logs-deployment ()
  (interactive)
  (let* ((name (read-string "Deployment: "))
        (ns (read-string "Namespace: "))
        (container (read-string "Container?: "))
        (buf (get-buffer-create (format "kubectl-logs-deployment/%s" name)))
        (command (if (string-blank-p container)
                     (format "%s logs deployment/%s -n %s --tail=250" moov/kubectl-path name ns)
                   (format "%s logs deployment/%s -n %s -c %s --tail=250" moov/kubectl-path name ns container))))

    (message (format "Running %s" command))

    ;; Clear buffer
    (switch-to-buffer buf)
    (narrow-to-region (point-min) (point-max))
    (erase-buffer)

    ;; Grab logs and write them to our buffer
    (insert (shell-command-to-string command))))
