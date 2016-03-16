;; sbt commands

(defalias 'sbt 'sbt-start)

(defun sbt/docker()
  (interactive)
  (sbt-command "docker"))

(defun sbt/run()
  (interactive)
  (sbt-command "run"))

(defun sbt/compile()
  (interactive)
  (sbt-command "compile"))

(defun sbt/test()
  (interactive)
  (sbt-command "test"))

(defun sbt/scripted-test()
  (interactive)
  (sbt-command "scripted"))

(defun sbt/cross-test()
  (interactive)
  (sbt-command "+test"))

(defun sbt/cross-test-compile()
  (interactive)
  (sbt-command "+test:compile"))

(defun sbt/test-compile()
  (interactive)
  (sbt-command "test:compile"))

(defun sbt/test-run()
  (interactive)
  (sbt-command "test:run"))

(defun sbt/publoc()
  (interactive)
  (sbt-command "publish-local"))

(defun sbt/assembly()
  (interactive)
  (sbt-command "assembly"))

(defun sbt/ci()
  (interactive)
  (sbt-command "ci"))

(defun sbt/clean()
  (interactive)
  (sbt-command "clean"))

;; copied from
;; https://github.com/jwinder/emacs/blob/emacs-24/emacs.org#scala
(defun sbt-current-test-in-buffer ()
  (interactive)
  (save-excursion
    (let* ((pkg-name-components)
           (test-names))
      (goto-char (point-min))
      (while (re-search-forward "package " nil t)
        (push (filter-buffer-substring (point) (point-at-eol)) pkg-name-components))
      (goto-char (point-min))
      (while (re-search-forward "\\(object\\|class\\) " nil t)
        (push (filter-buffer-substring (point) (progn (re-search-forward " ")
                                                      (forward-char -1)
                                                      (point)))
              test-names))
      (let* ((full-pkg-name (string-join (reverse pkg-name-components) "."))
             (full-test-names (mapcar #'(lambda (test-name) (string-join (list full-pkg-name "." test-name))) test-names))
             (full-test-names-str (string-join full-test-names " ")))
        (message full-test-names-str)))))

(defun sbt-test-only-current-test ()
  "Run test-only for the test in the current buffer"
  (interactive)
  (sbt-command (concat "test-only " (sbt-current-test-in-buffer))))

;; run N example(s) at a time
(defun sbt/run-specific-examples()
  "Run test-only for the matching examples"
  (interactive)
  (sbt-command (concat "test-only " (sbt-current-test-in-buffer) " -- ex zzz")))

;; Don't clear out the buffer before running an sbt command
;; (setq sbt:clear-buffer-before-command nil)

;; these help sometimes
(defun sbt/destroy-the-world()
  (interactive)
  (sbt-command "clean")
  (sbt-command "reload")
  (sbt-command "update"))

(defun sbt/destroy-then-rebuild-the-world()
  (interactive)
  (sbt-destroy-the-world)
  (sbt-command "compile"))

(setq comint-scroll-to-bottom-on-output nil)

(provide 'mine-sbt)
