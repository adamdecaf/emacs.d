;; org-mode setup
(require 'org)
(require 'color-theme)

(setq org-log-done t)

(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file "~/Dropbox/org/notes.org")

(setq org-capture-templates
      (quote (("t" "todo" entry (file (concat org-directory "/todo.org"))
               "** TODO %?" )
              ("n" "note" entry (file (concat org-directory "/notes.org"))
               "** %?" ))))

(setq org-agenda-files (list "~/Dropbox/org/banno.org"
                             "~/Dropbox/org/backln.org"
                             "~/Dropbox/org/personal.org"))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "white" :weight bold)
              ("NEXT" :foreground "red" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "blue" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "gray" :weight bold)
              ("MEETING" :foreground "yellow" :weight bold)
              ("PHONE" :foreground "orange" :weight bold))))

(provide 'mine-org)
