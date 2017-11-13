(defadvice newline-and-indent (after add-line-before-brace)
	"Inserts extra line if next character is closing curly brace or paren"
	(if (looking-at "[})]")
			(save-excursion 
				(newline)
				(scala-indent:indent-line)))
	(scala-indent:indent-line))

(defun sc-scala-wrap-case-class ()
  "Breaks a case class declaration into one arg per line"
  (interactive)
  (while (looking-at "[^)]")
    (if (looking-at "[(,]")
        (progn
          (forward-char 1)
          (newline-and-indent))
      (forward-char 1)))
  (newline-and-indent))

(global-set-key (kbd "C-c C-e w") 'sc-scala-wrap-case-class)
