;; org-mode setup
(require 'org)
(require 'org-install)

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
       (file-expand-wildcards "~/Dropbox/org/*.org")))

(setq org-todo-keywords
      '((sequence "BLOCKED(b)" "WATCH(w)" "STARTED(s)" "TODO(t)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-todo-keyword-faces
      '(("BLOCKED" . "red3")
        ("WATCH" . "pink")
        ("STARTED" . "gold")
        ("TODO" . "white")
        ("NEXT" . "yellow")
        ("DONE" . "green")
        ("CANCELLED" . "gray")))

(setq org-agenda-custom-commands
      '(("n" "Agenda and all TODO's" ((agenda "") (alltodo "")))
        ("w" todo "WATCH"
         ((org-agenda-sorting-strategy '(priority-down))
          (org-agenda-prefix-format "  Mixed: ")))))

;; setup babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (sql . t)
   ))

;; org-reveal
(require 'ox-reveal)
(setq org-reveal-root "file:///Users/adam/src/banno/internal-talks/")

;; helpers
(defvar org-buffer-switched-to-history nil)
(defun mine/org-switch-to-file()
  (interactive)
  ;; todo: banno-ff, backln-ff, backline-ff have special meanings
  (let ((last-buffer-name (read-from-minibuffer "Org File: " (car org-buffer-switched-to-history) nil nil 'org-buffer-switched-to-history)))
    (find-file (concat "~/Dropbox/org/" last-buffer-name ".org"))))

(provide 'mine-org)
