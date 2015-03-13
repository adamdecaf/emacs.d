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

(defun mine-browse-hacker-news()
  (interactive)
  (w3m-goto-url-new-session "http://news.ycombinator.com"))

(provide 'mine-w3m)
