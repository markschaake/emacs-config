(defadvice newline-and-indent (after add-line-before-brace)
	"Inserts extra line if next character is right curly brace"
	(if (looking-at "[})]")
			(save-excursion 
				(newline)
				(scala-indent:indent-line)))
	(scala-indent:indent-line))

