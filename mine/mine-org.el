;; org-mode setup
(require 'org)
(setq org-log-done t)

(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file "~/Dropbox/org/notes.org")

(setq org-capture-templates
      (quote (("t" "todo" plain (file (concat org-directory "/incoming.org"))
               "** TODO %?")
              ("N" "next" plain (file (concat org-directory "/incoming.org"))
               "** NEXT %?")
              ("n" "note" plain (file (concat org-directory "/incoming.org"))
               "** %?" ))))

(setq org-agenda-files
      (append
       (file-expand-wildcards "~/src/banno/firefighter-notes/*/data-services/ff.org")
       (file-expand-wildcards "~/Dropbox/org/*.org")))

(setq org-todo-keywords
      '((sequence "IDEA(i)")
        (sequence "QUESTION(i)")
        (sequence "BLOCKED(b)" "WATCH(w)" "STARTED(s)" "TODO(t)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-todo-keyword-faces
      '(("IDEA" . "DodgerBlue4")
        ("HOLD" . "purple")
        ("WAITING" . "light blue")
        ("LATER" . "blue")
        ("DONE" . "green")
        ("QUESTION" . "dark green")
        ("CANCELLED" . "gray")
        ("BLOCKED" . "red3")
        ("WATCH" . "pink")
        ("TODO" . "white")
        ("NEXT" . "red")
        ("ASK" . "orange")
        ("STARTED" . "gold")))

(setq org-agenda-custom-commands
      '(("n" "Agenda and all TODO's" ((agenda "") (alltodo "")))
        ("w" todo "WATCH"
         ((org-agenda-sorting-strategy '(priority-down))
          (org-agenda-prefix-format "  Mixed: ")))))

;; org-reveal
(require 'ox-reveal)
(setq org-reveal-root "file:///Users/adam/src/banno/internal-talks/")

;; helpers
(defvar org-buffer-switched-to-history nil)
(defun mine-org-switch-to-file()
  (interactive)
  ;; todo: banno-ff, backln-ff, backline-ff have special meanings
  (let ((last-buffer-name (read-from-minibuffer "Org File: " (car org-buffer-switched-to-history) nil nil 'org-buffer-switched-to-history)))
    (find-file (concat "~/Dropbox/org/" last-buffer-name ".org"))))

(provide 'mine-org)
