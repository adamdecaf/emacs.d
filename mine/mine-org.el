;; org-mode setup
(require 'org)
(require 'org-install)

(setq org-log-done t)

(setq org-directory "~/Dropbox/org")

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

;; helpers
(defvar org-buffer-switched-to-history nil)
(defun mine/org-switch-to-file()
  (interactive)
  (let ((last-buffer-name (read-from-minibuffer "Org File: " (car org-buffer-switched-to-history) nil nil 'org-buffer-switched-to-history)))
    (find-file (concat "~/Dropbox/org/" last-buffer-name ".org"))))

;; RSS feeds
(setq org-feed-alist
      '((;; News
         "Al Jazeera"
         "http://www.aljazeera.com/xml/rss/all.xml" "~/Dropbox/org/feeds.org" "Al Jazeera" :filter mine/org-feed-strip-html)
        ;; ("BBC Top Stories"
        ;;  "http://feeds.bbci.co.uk/news/rss.xml" "~/Dropbox/org/feeds.org" "BBC Top Stories" :filter mine/org-feed-strip-html)
        ;; ("Des Moines Register"
        ;;  "http://rssfeeds.desmoinesregister.com/desmoines/news&x=1" "~/Dropbox/org/feeds.org" "Des Moines Register" :filter mine/org-feed-strip-html)
        ;; ("Infowars"
        ;;  "http://www.infowars.com/feed/custom_feed_rss" "~/Dropbox/org/feeds.org" "Infowars" :filter mine/org-feed-strip-html)
        ("Longform"
         "https://longform.org/feed.rss" "~/Dropbox/org/feeds.org" "Longform.org" :filter mine/org-feed-strip-html)

        ;; no guids :(
        ;; ("FiveThirtyEight Politics"
        ;;  "https://fivethirtyeight.com/politics/feed" "~/Dropbox/org/feeds.org" "FiveThirtyEight Politics")
        ;; ("FiveThirtyEight Economics"
        ;;  "https://fivethirtyeight.com/economics/feed" "~/Dropbox/org/feeds.org" "FiveThirtyEight Economics")

        ;; Blogs
        ;; ("Scary Beast"
        ;;  "https://scarybeastsecurity.blogspot.com/feeds/posts/default" "~/Dropbox/org/feeds.org" "Scary Beasts" :filter mine/org-feed-strip-html)

        ;; Tech
        ("Hackernews" ;; https://news.ycombinator.com/rss doesn't have guid
         "http://hnrss.org/newest?points=100" "~/Dropbox/org/feeds.org" "Hackernews" :filter mine/org-feed-clean-hacker-news)

        ;; Weather
        ("DSM Weather"
         "http://w1.weather.gov/xml/current_obs/KDSM.rss" "~/Dropbox/org/feeds.org" "DSM Weather" :filter mine/org-feed-strip-html)
        ))


(defun mine/strip-cdata (text)
  (if (not text)
      (setq text ""))
  (string-trim
   (replace-regexp-in-string (regexp-quote "<![CDATA[") ""
                             (replace-regexp-in-string (regexp-quote "]]>") "" text))))

(defun mine/strip-html (text)
  (if (not text)
      (setq text ""))
  (string-trim
   (replace-regexp-in-string "<[a-zA-Z]*.*/>" ""
                             (replace-regexp-in-string "<.*>.*</[a-zA-Z]*>" "" text))))

;; filter org-mode feeds
(defun mine/org-feed-clean (f e)
  (let* ((title (funcall f (plist-get e :title)))
         (desc  (funcall f (plist-get e :description))))
    (plist-put e :title title)
    (plist-put e :description desc)))

(defun mine/org-feed-cleanse-cdata-tags (e)
  (mine/org-feed-clean mine/strip-cdata e))

(defun mine/org-feed-strip-html (e)
  (mine/org-feed-clean (lambda (e)
                         (mine/strip-html
                          (mine/strip-cdata e)))
                       e))

;; Hacker news custom filter
(defun mine/org-feed-capture-comments-url (text)
  (let* ((raw (when (string-match "Comments URL: <a href=\"\\(.*\\)\"" text)
                (match-string 0 text))))
    (if (not raw)
        (setq raw ""))
    (string-trim
     (replace-regexp-in-string "\"?" ""
                               (replace-regexp-in-string
                                "URL: <a href=\""
                                ""
                                raw)
                               ))))

(defun mine/org-feed-clean-hacker-news (e)
  (let* ((desc (plist-get e :description))
         (comments (mine/org-feed-capture-comments-url desc))
         (item (mine/org-feed-strip-html e)))
    (message "%s" comments)
    (if (and comments
             (not (zerop (length comments))))
        (plist-put item :description comments))))

(provide 'mine-org)
