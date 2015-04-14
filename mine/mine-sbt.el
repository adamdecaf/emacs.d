;; sbt commands

(defalias 'sbt 'sbt-start)

(defun sbt-docker()
  (interactive)
  (sbt-command "docker"))

(defun sbt-run()
  (interactive)
  (sbt-command "run"))

(defun sbt-compile()
  (interactive)
  (sbt-command "compile"))

(defun sbt-test()
  (interactive)
  (sbt-command "test"))

(defun sbt-scripted-test()
  (interactive)
  (sbt-command "scripted"))

(defun sbt-cross-test()
  (interactive)
  (sbt-command "+test"))

(defun sbt-cross-test-compile()
  (interactive)
  (sbt-command "+test:compile"))

(defun sbt-test-compile()
  (interactive)
  (sbt-command "test:compile"))

(defun sbt-publoc()
  (interactive)
  (sbt-command "publish-local"))

(defun sbt-assembly()
  (interactive)
  (sbt-command "assembly"))

(defun sbt-ci()
  (interactive)
  (sbt-command "ci"))

(defun sbt-clean()
  (interactive)
  (sbt-command "clean"))

(defun sbt-clear-local-banno-artifacts()
  (interactive)
  (sbt-command "clear-local-banno-artifacts"))

;; copied from
;; https://github.com/rubbish/sbt.el/blob/master/sbt.el#L179
(defun sbt-current-test-in-buffer ()
  (save-excursion
    (goto-char (point-min))
    (let* ((pkg-name (progn
                       (re-search-forward "package ")
                       (filter-buffer-substring (point) (point-at-eol))))
           (test-name (progn
                        (re-search-forward "\\(object\\|class\\) ")
                        (filter-buffer-substring
                         (point)
                         (progn
                           (re-search-forward " ")
                           (forward-char -1)
                           (point))))))
      (concat pkg-name "." test-name))))

(defun sbt-test-only-current-test ()
  "Run test-only for the test in the current buffer"
  (interactive)
  (sbt-command (concat "test-only " (sbt-current-test-in-buffer))))

;; Don't clear out the buffer before running an sbt command
;; (setq sbt:clear-buffer-before-command nil)

;; these help sometimes
(defun sbt-destroy-the-world()
  (interactive)
  (sbt-command "clean")
  (sbt-command "reload")
  (sbt-command "update"))

(defun sbt-destroy-then-rebuild-the-world()
  (interactive)
  (sbt-destroy-the-world)
  (sbt-command "compile"))

(provide 'mine-sbt)
