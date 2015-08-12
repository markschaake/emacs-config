;; functions for managing imports according to AI2 standards

(defun ai2-sort-imports ()
  "sort em"
  (save-excursion
    (let ((imports-start (ai2-import-begin "import .*"))
          (imports-end (ai2-import-end "import .*")))
      (if (and imports-start imports-end)
          (progn
            (sort-lines nil imports-start imports-end)
            ;; now remove duplicates
            (goto-line 3)
            (while (search-forward-regexp "\\(import .*\\)\n\\(\\1\\)$" nil t)
              (replace-match "\\1")
              (goto-line 3)))))))

(defun ai2-move-allenai-to-top ()
  "move em"
  (save-excursion
    (let ((imports-start (ai2-import-begin "import .*")))
      (let ((start (ai2-import-begin "import org\.allenai\..*"))
            (end (ai2-import-end "import org\.allenai\..*")))
        (if (and imports-start start end)
            (funcall (lambda ()
                       (kill-region start end)
                       (goto-char imports-start)
                       (open-line 1)
                       (yank)
                       (ai2-collapse-imports))))))))


(defun ai2-move-imports-to-bottom (prefix)
  "move a block of imports with prefix to the bottom"
  (save-excursion
    (let ((imports-start (ai2-import-begin "import .*")))
      (let ((start (ai2-import-begin prefix))
            (end (ai2-import-end prefix)))
        (if (and start end)
            (funcall (lambda ()
                       (kill-region start end)
                       (ai2-collapse-imports)
                       (let ((imports-end (or
                                           (ai2-import-end "import .*")
                                           (funcall (lambda ()
                                                      (goto-char (point-min))
                                                      (forward-line 2)
                                                      (point))))))
                         (goto-char imports-end)
                         (open-line 1)
                         (forward-char)
                         (yank)))))))))

(defun ai2-fixup-curlies ()
  "Puts space in between curly braces"
  (save-excursion
    (let ((imports-start (ai2-import-begin "import .*"))
          (imports-end (ai2-import-end "import .*")))
      (replace-regexp "\.{\\([^ ].*[^ ]\\)}" ".{ \\1 }" nil imports-start imports-end))))

(defun ai2-organize-imports ()
  "Sorts all imports and then splits them into three groups"
  (interactive)
  (let ((scala-java-patt "\\(import java\..*$\\|import scala\..*$\\)"))
    (ai2-collapse-imports)
    (ai2-sort-imports)
    (ai2-fixup-curlies)
    (ai2-move-allenai-to-top)
    (ai2-move-imports-to-bottom scala-java-patt)
    (ai2-newline-after "import org.allenai\..*")
    (ai2-newline-before scala-java-patt)))

(defun ai2-newline-after (patt)
  "Adds a newline after the matched lines"
  (save-excursion
    (when (ai2-import-begin patt)
      (goto-char (ai2-import-begin patt))
      (let ((greedy-patt (concat "\\(" patt "\n\\)+")))
        (when (search-forward-regexp greedy-patt nil t)
          (goto-char (match-end 0))
          (open-line 1))))))

(defun ai2-newline-before (patt)
  "Adds a newline after the matched lines"
  (save-excursion
    (when (ai2-import-begin patt)
      (goto-char (ai2-import-begin patt))
      (open-line 1))))

(defun ai2-import-begin (patt)
  "Returns position of begin of import block where imports match pattern, or nil"
  (save-excursion
    (goto-line 3)
    (when (search-forward-regexp patt nil t)
      (match-beginning 0))))


(defun ai2-import-end (patt)
  "Returns point at end of block of imports matching pattern, or nil"
  (save-excursion
    (let ((import-begin (ai2-import-begin patt)))
      (if import-begin
          (funcall (lambda ()
                     (goto-char (ai2-import-begin patt))
                     (let ((greedy-patt (concat "\\(" patt "\n\\)+")))
                       (when (search-forward-regexp greedy-patt nil t)
                         (- (match-end 0) 1)))))))))
    


(defun ai2-collapse-imports ()
  "Removes empty lines betweens imports"
  (save-excursion
    (goto-line 3)
    (while (search-forward-regexp "\\(import .*\\)\n\n+\\(import .*\\)" nil t)
      (replace-match "\\1\n\\2")
      (goto-line 3))))


(defun current-line ()
  "Current line as string"
  (let ((p1 (line-beginning-position))
        (p2 (line-end-position)))
    (buffer-substring-no-properties p1 p2)))
