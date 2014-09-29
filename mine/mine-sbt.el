;; sbt commands

(defun sbt-compile()
  "Run `compile` in an sbt project."
  (interactive)
  (sbt-command "compile"))

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

(provide 'mine-sbt)
