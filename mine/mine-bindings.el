;; fix buffer switching
(global-set-key [remap list-buffers] 'bs-show)

;; eshell
(global-set-key (kbd "C-x m") 'eshell)
(global-set-key (kbd "C-x C-n") 'mine/eshell-pick-and-choose)
(global-set-key (kbd "C-x C-m") 'mine/eshell-switch-to-closest-or-create-here)

;; date/time
(global-set-key (kbd "C-c d") 'mine/insert-date)
(global-set-key (kbd "C-c t") 'mine/insert-iso-timestamp)

;; org
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-x C-o") 'mine/org-switch-to-file)

;; frame/window
(global-set-key (kbd "C-x 7") 'mine/swap-windows)
(global-set-key (kbd "C-x 8") 'mine/toggle-window-split)
(global-set-key (kbd "C-x 9") 'mine/toggle-window-split)

;; text
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-c o") 'mine/indent-buffer)
(global-set-key (kbd "C-x a r") 'align-regexp)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-set-key [remap sh-case] 'comment-or-uncomment-region)
(global-set-key [remap move-beginning-of-line] 'mine/beginning-of-line-or-back-to-indention)

;; movement
(global-set-key (kbd "C-c C-b") 'beginning-of-buffer)
(global-set-key (kbd "C-c C-e") 'end-of-buffer)

;; docview mode
(global-set-key (kbd "C-c n") 'doc-view-next-page)
(global-set-key (kbd "C-c p") 'doc-view-previous-page)

;; sbt-mode
(global-set-key (kbd "C-c s d") 'sbt/docker)
(global-set-key (kbd "C-c s r") 'sbt/run)
(global-set-key (kbd "C-c s t") 'sbt/test)
(global-set-key (kbd "C-c s s") 'sbt/scripted-test)
(global-set-key (kbd "C-c s c") 'sbt/compile)
(global-set-key (kbd "C-c s T") 'sbt/test-compile)
(global-set-key (kbd "C-c s o") 'sbt-test-only-current-test)
(global-set-key (kbd "C-c s x") 'sbt/run-specific-examples)

;; json validate
(global-set-key (kbd "C-x j f") 'json-reformat-region)

;; magit
(global-set-key (kbd "C-x C-g") 'magit-status)
(global-set-key (kbd "C-x C-p") 'magit-pull)
(global-set-key (kbd "C-c C-p") 'magit-push)
(global-set-key (kbd "C-x C-l") 'magit-log)

(provide 'mine-bindings)
