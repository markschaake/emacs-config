;;; package --- Summary
;;; Commentary:
;;; Code:

(require 'lsp-ui)

(defadvice newline-and-indent (after add-line-before-brace)
  "Insert extra line if next character is closing curly brace or paren."
  (if (looking-at "[})]")
      (save-excursion
        (newline)
        (scala-indent:indent-line)))
  (scala-indent:indent-line))

(defun sc-scala-wrap-case-class ()
  "Break a case class declaration into one arg per line."
  (interactive)
  (while (looking-at "[^)]")
    (if (looking-at "[(,]")
        (progn
          (forward-char 1)
          (newline-and-indent))
      (forward-char 1)))
  (newline-and-indent))

(defun sc-sbt-do-re-start ()
  "Execute the sbt `reStart' command for the project."
  (interactive)
  (sbt:command "reStart"))

(defun sc-sbt-compile ()
  "Execute the sbt `compile` command for the projcet."
  (interactive)
  (sbt:command "test:compile"))


(defun sc-scala-file-name-no-suffix ()
  "Return the file name without a suffix.  For example:
/foo/bar/Baz.scala would return Baz"
  (file-name-sans-extension buffer-file-name))

(defun sc-sbt-test-only-current-buffer ()
  "Run sbt/testOnly on the current buffer.  Assumes sbt is already set to current project."
  (interactive)
  (let ((arg (concat "testOnly" " *" (file-name-sans-extension (file-name-nondirectory buffer-file-name)))))
    ;(message (concat "sbt " arg))
    (sbt:command arg)))

(defun sc-scala-set-local-keys ()
  "Set local key bindings for custom functions."
  (local-set-key (kbd "C-c C-b C-r") 'sc-sbt-do-re-start)
  (local-set-key (kbd "C-c C-b C-r") 'sc-sbt-do-re-start)
  (local-set-key (kbd "C-c C-b c") 'sc-sbt-compile)
  (local-set-key (kbd "C-c C-b s") 'sbt-start)
  (local-set-key (kbd "C-c C-b C-c") 'sc-sbt-compile)
  (local-set-key (kbd "C-c C-b t") 'sc-sbt-test-only-current-buffer)
  (local-set-key (kbd "C-c C-c w") 'sc-scala-wrap-case-class)
  (local-set-key (kbd "C-c C-c r") 'lsp-find-references)
  (local-set-key (kbd "C-c C-c f") 'lsp-format-buffer))

(provide 'sc-enhance-scala-mode)
;;; sc-enhance-scala-mode.el ends here
