;; functions for managing imports according to AI2 standards

(defun ai2-sort-imports ()
  "sort em"
  (let ((imports-start (ai2-import-begin "import .*"))
        (imports-end (ai2-import-end "import .*")))
    (sort-lines nil imports-start imports-end)))


(defun ai2-move-allenai-to-top ()
  "move em"
  (save-excursion
    (let ((imports-start (ai2-import-begin "import .*")))
      (let ((start (ai2-import-begin "import org\.allenai\..*"))
            (end (ai2-import-end "import org\.allenai\..*")))
        (kill-region start end)
        (goto-char imports-start)
        (open-line 1)
        (yank)
        (ai2-collapse-imports)))))


(defun ai2-move-imports-to-bottom (prefix)
  "move a block of imports with prefix to the bottom"
  (save-excursion
    (let ((imports-start (ai2-import-begin "import .*")))
      (let ((start (ai2-import-begin prefix))
            (end (ai2-import-end prefix)))
        (kill-region start end)
        (ai2-collapse-imports)
        (let ((imports-end (ai2-import-end "import .*")))
          (goto-char imports-end)
          (open-line 1)
          (forward-char)
          (yank))))))


(defun ai2-move-java-to-bottom ()
  "move em"
  (ai2-move-imports-to-bottom "import java\..*"))

(defun ai2-move-scala-to-bottom ()
  "move em"
  (ai2-move-imports-to-bottom "import scala\..*"))

(defun ai2-organize-imports ()
  "Sorts all imports and then splits them into three groups"
  (interactive)
  (ai2-collapse-imports)
  (ai2-sort-imports)
  (ai2-move-allenai-to-top)
  (ai2-move-java-to-bottom)
  (ai2-move-scala-to-bottom)
  (ai2-newline-after "import org.allenai\..*")
  (ai2-newline-before "\\import java\..*\\|scala\..*"))

(defun ai2-newline-after (patt)
  "Adds a newline after the matched lines"
  (save-excursion
    (goto-char (ai2-import-begin patt))
    (let ((greedy-patt (concat "\\(" patt "\n\\)+")))
      (search-forward-regexp greedy-patt)
      (goto-char (match-end 0))
      (open-line 1))))

(defun ai2-newline-before (patt)
  "Adds a newline after the matched lines"
  (save-excursion
    (goto-char (ai2-import-begin patt))
    (open-line 1)))

(defun ai2-import-begin (patt)
  "Returns position of begin of import block where imports match patter"
  (save-excursion
    (goto-line 3)
    (search-forward-regexp patt)
    (match-beginning 0)))


(defun ai2-import-end (patt)
  "Returns point at end of block of imports matching pattern"
  (save-excursion
    (goto-char (ai2-import-begin patt))
    (let ((greedy-patt (concat "\\(" patt "\n\\)+")))
      (search-forward-regexp greedy-patt)
      (- (match-end 0) 1))))


(defun ai2-collapse-imports ()
  "Removes empty lines betweens imports"
  (save-excursion
    (goto-line 3)
    (while (search-forward-regexp "\\(import .*\\)\n\n+\\(import .*\\)" nil t)
      (replace-match "\\1\n\\2"))
    (goto-line 3)
    ;; now remove duplicates
    (while (search-forward-regexp "\\(import .*\\)\n\\(\\1\\)" nil t)
      (replace-match "\\1"))))

(defun current-line ()
  "Current line as string"
  (let ((p1 (line-beginning-position))
        (p2 (line-end-position)))
    (buffer-substring-no-properties p1 p2)))
