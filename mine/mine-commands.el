;; misc commands

;; symbols
(defun sigma ()
  (interactive)
  (insert "Σ"))

(defun big-o(v)
  (interactive "sBig O Value: ")
  (insert (format "O(%s)" v)))

(defun big-omega(v)
  (interactive "sBig Ω Value: ")
  (insert (format "Ω(%s)" v)))

(defun big-theta(v)
  (interactive "sBig Θ Value: ")
  (insert (format "Θ(%s)" v)))

;; pretty print xml
(defun mine-xml-pretty-print-region ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "xmllint --format -" nil t))

(provide 'mine-commands)
