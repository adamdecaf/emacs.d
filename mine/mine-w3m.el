;; w3m settings
;; inspired / taken from: http://www.emacswiki.org/emacs/WThreeMHintsAndTips

(require 'cl)

(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

(setq browse-url-browser-function 'w3m-browse-url
      browse-url-new-window-flag t)

(defun mine-set-linux-w3m-path()
  (push "/usr/bin/w3m" exec-path)
  (setq w3m-command "/usr/bin/w3m"))

(defun mine-set-osx-w3m-path()
  (push "/usr/local/bin/w3m" exec-path)
  (setq w3m-command "/usr/local/bin/w3m"))

(case system-type
  ('darwin (mine-set-osx-w3m-path))
  ('gnu/linux (mine-set-linux-w3m-path)))

(global-set-key (kbd "C-c b") 'w3m-browse-url)

(use-package w3m :ensure t)
(require 'w3m)

(defun mine-browse-lwn()
  (interactive)
  (w3m-goto-url-new-session "http://lwn.net"))

(defun mine-browse-hacker-news()
  (interactive)
  (w3m-goto-url-new-session "http://news.ycombinator.com"))

;; reddit
(defun mine-browse-reddit (&optional subreddit)
  (interactive)
  (if subreddit
      (w3m-goto-url-new-session (concat "http://m.reddit.com/r/" subreddit))
    (w3m-goto-url-new-session "http://m.reddit.com")))

(defvar w3m-last-subreddit-history nil)
(defun mine-browse-subreddit()
  (interactive)
  (let ((subreddit (read-from-minibuffer "/r/" (car w3m-last-subreddit-history) nil nil 'w3m-last-subreddit-history)))
    (mine-browse-reddit subreddit)))

;; security lists
(defun mine-browse-full-disclosure()
  (interactive)
  (w3m-goto-url-new-session "http://seclists.org/fulldisclosure/"))

(defun mine-browse-openssl-announce()
  (interactive)
  (w3m-goto-url-new-session "https://marc.info/?l=openssl-announce"))

(setq w3m-use-title-buffer-name t)

;; open links in the background
;; from: http://sci.rutgers.edu/forum/showthread.php?137111-Emacs-w3m-open-link-in-background-tab
(defun rand-w3m-view-this-url-background-session ()
  (interactive)
  (let ((in-background-state w3m-new-session-in-background))
    (setq w3m-new-session-in-background t)
    (w3m-view-this-url-new-session)
    (setq w3m-new-session-in-background in-background-state)))

(defun my-w3m-bindings ()
  (define-key w3m-mode-map (kbd "C-<return>") 'rand-w3m-view-this-url-background-session))

(add-hook 'w3m-mode-hook 'my-w3m-bindings)

(provide 'mine-w3m)
