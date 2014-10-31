;; org-mode setup
(require 'org)
(setq org-log-done t)

(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file "~/Dropbox/org/notes.org")

(setq org-capture-templates
      (quote (("t" "todo" plain (file (concat org-directory "/todo.org"))
               "** TODO %?" )
              ("n" "note" plain (file (concat org-directory "/notes.org"))
               "** %?" ))))

(setq org-agenda-files (list "~/Dropbox/org/banno.org"
                             "~/Dropbox/org/backln.org"
                             "~/Dropbox/org/personal.org"))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(provide 'mine-org)
