;; org-mode setup
(require 'org)
(setq org-log-done t)

(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file "~/Dropbox/org/notes.org")

(setq org-capture-templates
      (quote (("t" "todo" plain (file (concat org-directory "/todo.org"))
               "** TODO %?")
              ("N" "next" plain (file (concat org-directory "/next.org"))
               "** NEXT %?")
              ("n" "note" plain (file (concat org-directory "/notes.org"))
               "** %?" ))))

(setq org-agenda-files (list "~/Dropbox/org/backln.org"
                             "~/Dropbox/org/banno.org"
                             "~/Dropbox/org/images.org"
                             "~/Dropbox/org/notes.org"
                             "~/Dropbox/org/personal.org"
                             "~/Dropbox/org/todo.org"))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)" "WATCH(w)")
              (sequence "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

;; org-reveal
(require 'ox-reveal)
(setq org-reveal-root "file:///Users/adam/src/banno/internal-talks/")

(provide 'mine-org)
