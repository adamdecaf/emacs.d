(setq display-time-format "\s(%I:%M%p %a %m/%d/%y)\s")
(setq display-time-mail-file -1)
(setq display-time-default-load-average nil)

(custom-set-faces
 '(mode-line ((t (:family "Monaco" :background nil :foreground "#ff7a58" :box nil))))
 '(mode-line-inactive ((t (:family "Monaco" :background nil :foreground "gray" :box nil))))
 '(mode-line-buffer-id ((t :family "Monaco" :background nil :foreground "#7db5d6"))))

(provide 'mine-mode-line)
