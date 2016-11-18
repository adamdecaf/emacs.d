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

;; helpers
(defvar org-buffer-switched-to-history nil)
(defun mine/org-switch-to-file()
  (interactive)
  ;; todo: banno-ff, backln-ff, backline-ff have special meanings
  (let ((last-buffer-name (read-from-minibuffer "Org File: " (car org-buffer-switched-to-history) nil nil 'org-buffer-switched-to-history)))
    (find-file (concat "~/Dropbox/org/" last-buffer-name ".org"))))

;; RSS feeds
(setq org-feed-alist
      '((;; News
         "Al Jazeera"
         "http://www.aljazeera.com/xml/rss/all.xml" "~/Dropbox/org/feeds.org" "Al Jazeera" :filter mine/org-feed-cleanse-cdata-tags)

        ;; no guids :(
        ;; ("FiveThirtyEight Politics"
        ;;  "https://fivethirtyeight.com/politics/feed" "~/Dropbox/org/feeds.org" "FiveThirtyEight Politics")
        ;; ("FiveThirtyEight Economics"
        ;;  "https://fivethirtyeight.com/economics/feed" "~/Dropbox/org/feeds.org" "FiveThirtyEight Economics")

        ;; Tech
        ("Hackernews" ;; https://news.ycombinator.com/rss doesn't have guid
         "http://hnrss.org/newest?points=100" "~/Dropbox/org/feeds.org" "Hackernews" :filter mine/org-feed-cleanse-cdata-tags)

        ;; Weather
        ("DSM Weather"
         "http://w1.weather.gov/xml/current_obs/KDSM.rss" "~/Dropbox/org/feeds.org" "DSM Weather" :filter mine/org-feed-cleanse-cdata-tags)
        ))

(defun mine/strip-html (text)
  (string-trim
   (replace-regexp-in-string (regexp-quote "</?[a-zA-Z]*>") ""
                             (replace-regexp-in-string (regexp-quote "<![CDATA[") ""
                                                       (replace-regexp-in-string (regexp-quote "]]>") "" text)))))

(defun mine/org-feed-cleanse-cdata-tags(e)
  (plist-put e :title (mine/strip-html (plist-get e :title)))
  (plist-put e :description (mine/strip-html (plist-get e :description))))

(provide 'mine-org)
