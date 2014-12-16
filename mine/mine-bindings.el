;; fix buffer switching
(global-set-key [remap list-buffers] 'bs-show)

;; eshell
(global-set-key (kbd "C-x m") 'eshell)
(global-set-key (kbd "C-x C-n") 'mine-eshell-pick-and-choose)
(global-set-key (kbd "C-x C-m") 'mine-eshell-switch-to-closest-or-create-here)

;; date/time
(global-set-key (kbd "C-c d") 'insert-date)
(global-set-key (kbd "C-c t") 'insert-iso-timestamp)
(global-set-key (kbd "C-x t") 'mine-message-the-time)

;; org
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-x C-o") 'mine-org-switch-to-file)

;; frame/window
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x 7") 'swap-windows)
(global-set-key (kbd "C-x 8") 'toggle-window-split)
(global-set-key (kbd "C-x 9") 'toggle-window-split)

;; buffers
(global-set-key (kbd "C-c k") 'delete-this-buffer-and-file)
(global-set-key (kbd "C-x C-r") 'rename-file-and-buffer)

;; text
(global-set-key (kbd "C-x a r") 'align-regexp)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-c o") 'indent-buffer)
(global-set-key [remap move-beginning-of-line] 'beginning-of-line-or-back-to-indention)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-set-key [remap sh-case] 'comment-or-uncomment-region)
(global-set-key (kbd "C-c r") 'comment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)

;; movement
(global-set-key (kbd "C-c C-b") 'beginning-of-buffer)
(global-set-key (kbd "C-c C-e") 'end-of-buffer)

;; marking
;; (global-set-key (kbd "C-<") 'mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mark-next-like-this)
;; (global-set-key (kbd "C-M-m") 'mark-more-like-this)
;; (global-set-key (kbd "C-*") 'mark-all-like-this)

;; rcirc
;;(global-set-key (kbd "C-c r c") 'rcirc) ;; reconnect...
;;(global-set-key (kbd "C-c r u") 'rcirc-jump-to-first-unread-line)
;;(global-set-key (kbd "C-c r s") 'mine-rcirc-shut-up)
;;(global-set-key (kbd "C-c r t") 'mine-rcirc-talk-to-me)

;; docview mode
(global-set-key (kbd "C-c n") 'doc-view-next-page)
(global-set-key (kbd "C-c p") 'doc-view-previous-page)

;; sbt-mode
(global-set-key (kbd "C-c s d") 'sbt-docker)
(global-set-key (kbd "C-c s r") 'sbt-run)
(global-set-key (kbd "C-c s t") 'sbt-test)
(global-set-key (kbd "C-c s s") 'sbt-scripted-test)
(global-set-key (kbd "C-c s c") 'sbt-compile)
(global-set-key (kbd "C-c s o") 'sbt-test-only-current-test)

;; erlang-mode
(global-set-key (kbd "C-c e c") 'erlang-compile)
(global-set-key (kbd "C-c e i") 'erlang-indent-current-buffer)
(global-set-key (kbd "C-c e s") 'erlang-shell)

;; clojure-mode
(global-set-key (kbd "C-c j l") 'clojure-load-file)

;; json validate
(global-set-key (kbd "C-x j f") 'json-reformat-region)

;; magit
(global-set-key (kbd "C-x C-g") 'magit-status)
(global-set-key (kbd "C-x C-p") 'magit-pull)
(global-set-key (kbd "C-c C-p") 'magit-push)
(global-set-key (kbd "C-x C-l") 'magit-log)

;; increment/decrement numbers
(global-set-key (kbd "C-c +") 'mine-increment-decimal)
(global-set-key (kbd "C-c =") 'mine-increment-decimal)
(global-set-key (kbd "C-c -") 'mine-decrement-decimal)

(provide 'mine-bindings)
