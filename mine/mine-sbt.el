;; sbt commands

(defalias 'sbt 'sbt-start)

(defun sbt-compile()
  "Run `compile` in an sbt project."
  (interactive)
  (sbt-command "compile"))

(defun sbt-test()
  "Run `test` in an sbt project."
  (interactive)
  (sbt-command "test"))

(defun sbt-cross-test()
  "Run +test to test all cross versions of a build."
  (interactive)
  (sbt-command "+test"))

(defun sbt-cross-test-compile()
  "Run +test:compile to compile all test sources for a cross versions of a build."
  (interactive)
  (sbt-command "+test:compile"))

(defun sbt-test-compile()
  "Switch to sbt buffer and run test:compile"
  (interactive)
  (sbt-command "test:compile"))

(defun sbt-publoc()
  "Publish this artifact locally"
  (interactive)
  (sbt-command "publish-local"))

(defun sbt-assembly()
  "Switch to sbt buffer and run assembly"
  (interactive)
  (sbt-command "assembly"))

(defun sbt-clear-local-banno-artifacts()
  "Clear local banno artifacts"
  (interactive)
  (sbt-command "clear-local-banno-artifacts"))

(defun sbt-ci()
  "Run sbt 'ci'"
  (interactive)
  (sbt-command "ci"))

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

(provide 'mine-sbt)
