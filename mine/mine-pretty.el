;; pretty stuff
;; some overrides i have

(require 'color-theme)
(color-theme-initialize)
(color-theme-wombat)

(color-theme-install
 `(color-theme-wombat
   ((background-color . "black")
    (background-mode . dark)
    ;; (forgroung-mode . dark)
    (cursor-color . "white")
    (foreground-color . ,wombat-fg)
    (mouse-color . "black"))

   ;; org
   ;; from http://orgmode.org/worg/color-themes/color-theme-manoj.el
   (org-agenda-date ((t (:foreground "LightSkyBlue"))))
   (org-agenda-date-weekend ((t (:bold t :foreground "LightSkyBlue" :weight bold))))
   (org-agenda-restriction-lock ((t (:background "skyblue4"))))
   (org-agenda-structure ((t (:foreground "LightSkyBlue"))))
   (org-archived ((t (:foreground "grey70"))))
   (org-code ((t (:foreground "grey70"))))
   (org-column ((t (:background "grey30" :strike-through nil :underline nil :slant normal :weight normal :height 81 :family "unknown-DejaVu Sans Mono"))))
   (org-column-title ((t (:bold t :background "grey30" :underline t :weight bold))))
   (org-date ((t (:foreground "Cyan" :underline t))))
   (org-done ((t (:bold t :foreground "PaleGreen" :weight bold))))
   (org-drawer ((t (:foreground "LightSkyBlue"))))
   (org-ellipsis ((t (:foreground "LightGoldenrod" :underline t))))
   (org-formula ((t (:foreground "chocolate1"))))
   (org-headline-done ((t (:foreground "LightSalmon"))))
   (org-hide ((t (:foreground "black"))))
   (org-latex-and-export-specials ((t (:foreground "burlywood"))))
   (org-level-1 ((t (:foreground "LightSkyBlue"))))
   (org-level-2 ((t (:foreground "LightGoldenrod"))))
   (org-level-3 ((t (:foreground "Cyan1"))))
   (org-level-4 ((t (:foreground "chocolate1"))))
   (org-level-5 ((t (:foreground "PaleGreen"))))
   (org-level-6 ((t (:foreground "Aquamarine"))))
   (org-level-7 ((t (:foreground "LightSteelBlue"))))
   (org-level-8 ((t (:foreground "LightSalmon"))))
   (org-link ((t (:foreground "Cyan" :underline t))))
   (org-property-value ((t (nil))))
   (org-scheduled-previously ((t (:foreground "chocolate1"))))
   (org-scheduled-today ((t (:foreground "PaleGreen"))))
   (org-sexp-date ((t (:foreground "Cyan"))))
   (org-special-keyword ((t (:foreground "LightSalmon"))))
   (org-table ((t (:foreground "LightSkyBlue"))))
   (org-tag ((t (:bold t :weight bold))))
   (org-target ((t (:underline t))))
   (org-time-grid ((t (:foreground "LightGoldenrod"))))
   (org-todo ((t (:bold t :foreground "Pink" :weight bold))))
   (org-upcoming-deadline ((t (:foreground "chocolate1"))))
   (org-verbatim ((t (:foreground "grey70" :underline t))))
   (org-warning ((t (:bold t :weight bold :foreground "Pink"))))
   (outline-1 ((t (:foreground "LightSkyBlue"))))
   (outline-2 ((t (:foreground "LightGoldenrod"))))
   (outline-3 ((t (:foreground "Cyan1"))))
   (outline-4 ((t (:foreground "chocolate1"))))
   (outline-5 ((t (:foreground "PaleGreen"))))
   (outline-6 ((t (:foreground "Aquamarine"))))
   (outline-7 ((t (:foreground "LightSteelBlue"))))
   (outline-8 ((t (:foreground "LightSalmon"))))

   ;; magit
   (magit-diff-del ((t (:foreground "#ff0080")))) ; "#ffaaaa"
   (magit-diff-add ((t (:foreground "#1AFF84")))) ; "#aaffaa"
   (diff-added ((t (:inherit magit-diff-add))))
   (diff-removed ((t (:inherit magit-diff-del))))

   ))

(setq magit-item-highlight t)

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

(provide 'mine-pretty)
