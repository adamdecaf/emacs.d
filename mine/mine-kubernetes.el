;; From https://github.com/bowei/kube.el
;; (setq kube-kubectl-exec  "/usr/local/bin/kubectl")
;;
;; I had to add the following in kube--exec-command
;; "--context" "k8s-banno-staging-context"


;; Settings for https://github.com/chrisbarrett/kubernetes-el
(setq kubernetes-kubectl-executable
      ;; From gcloud cli
      "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/kubectl")

;; Lower refresh interval
;; https://github.com/chrisbarrett/kubernetes-el/issues/100#issuecomment-503684843
(setq kubernetes-poll-frequency 3600)
(setq kubernetes-redraw-frequency 3600)

(provide 'mine-kubernetes)
