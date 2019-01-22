;; languages

;; setup javascript indenting
(setq js-indent-level 2)

;; protobuf files are like c
(add-to-list 'auto-mode-alist '("\\.proto\\'" . c-mode))

;; ruby like files
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))

;; .hcl hashicorp config language files
(add-to-list 'auto-mode-alist '("\\.hcl\\'" . conf-mode))

;; Jenkinsfile's are in groovy
(add-to-list 'auto-mode-alist '("Jenkinsfile" . groovy-mode))

;; Tilt (local Kubernetes dev tool)
(add-to-list 'auto-mode-alist '("Tiltfile" . python-mode))

(provide 'mine-languages)
