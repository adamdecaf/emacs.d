;; w3m settings
;; inspired / taken from: http://www.emacswiki.org/emacs/WThreeMHintsAndTips

(require 'w3m)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

(setq browse-url-browser-function 'w3m-browse-url
      browse-url-new-window-flag t)

(global-set-key (kbd "C-c b") 'w3m-browse-url)

(provide 'mine-w3m)
