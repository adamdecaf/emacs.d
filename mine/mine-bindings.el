;; fix buffer switching
(global-set-key [remap list-buffers] 'bs-show)

;; org
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; frame/window
(global-set-key (kbd "C-x 7") 'swap-windows)
(global-set-key (kbd "C-x 8") 'toggle-window-split)
(global-set-key (kbd "C-x 9") 'toggle-window-split)

;; text
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-c o") 'indent-buffer)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
;; (global-set-key (kbd "C-c c r") 'comment-region)
(global-set-key (kbd "C-c u r") 'uncomment-region)

;; movement
(global-set-key (kbd "C-c C-b") 'beginning-of-buffer)
(global-set-key (kbd "C-c C-e") 'end-of-buffer)

;; marking
;; (global-set-key (kbd "C-<") 'mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mark-next-like-this)
;; (global-set-key (kbd "C-M-m") 'mark-more-like-this)
;; (global-set-key (kbd "C-*") 'mark-all-like-this)

;; rcirc
(global-set-key (kbd "C-c r c") 'rcirc) ;; reconnect...
(global-set-key (kbd "C-c r u") 'rcirc-jump-to-first-unread-line)
(global-set-key (kbd "C-c r s") 'mine-rcirc-shut-up)
(global-set-key (kbd "C-c r t") 'mine-rcirc-talk-to-me)

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

(provide 'mine-bindings)
