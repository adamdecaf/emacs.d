;; pretty things
(load-theme 'wombat)

(custom-set-faces '(magit-item-highlight ((t nil))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "white" :weight bold)
              ("NEXT" :foreground "red" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "blue" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "gray" :weight bold)
              ("MEETING" :foreground "yellow" :weight bold)
              ("PHONE" :foreground "orange" :weight bold))))

;; scala-mode2 settings
;; https://github.com/hvesalai/scala-mode2#parameter-lists-scala-indentalign-parameters
(setq scala-indent:align-parameters t)
(setq scala-indent:align-forms t)
(set-face-attribute 'font-lock-variable-name-face nil :foreground "DarkOrange1")

(defun mine-set-font-size (size)
  (interactive "sSize: ")
  (let ((font (concat "Menlo " size)))
    (set-frame-parameter (selected-frame) 'font font)
    (add-to-list 'default-frame-alist (cons 'font font))))

(provide 'mine-pretty)
