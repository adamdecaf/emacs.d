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

(provide 'mine-commands)
