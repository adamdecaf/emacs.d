;; languages

;; cause screw tabs
(setq js-indent-level 2)

;; protobuf files are like c
(add-to-list 'auto-mode-alist '("\\.proto\\'" . c-mode))

;; ruby like files
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))

(provide 'mine-languages)
