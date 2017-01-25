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

;; org-feed-alist is read from ~/.emacs.d/hidden.el

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
