;; org-mode setup
(require 'org)
(require 'org-install)

(setq org-log-done t)

(setq org-directory "~/archive")

(setq org-todo-keywords
      '((sequence "BLOCKED(b)" "STARTED(s)" "TODO(t)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-todo-keyword-faces
      '(("BLOCKED" . "red3")
        ("STARTED" . "gold")
        ("TODO" . "white")
        ("NEXT" . "yellow")
        ("DONE" . "green")
        ("CANCELLED" . "gray")))

;; Load up languages to use
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sh . t)))

(provide 'mine-org)
