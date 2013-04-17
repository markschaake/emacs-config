(defun balance-and-grow-window-to-fit-buffer ()
	(interactive)
	"Grows the current window vertically to fit the buffer"
	(balance-windows)
	(setq prev-point (point))
	(goto-char (point-min))
	(shrink-window-if-larger-than-buffer)
	(goto-char prev-point))

(global-set-key (kbd "C-c C-w b") 'balance-and-grow-window-to-fit-buffer)
