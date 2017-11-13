;; All custom window-related commands have key prefix C-c w

(defun kill-this-buffer-and-delete-window ()
  "Kills the current buffer and deletes the window"
  (interactive)
  (kill-this-buffer)
  (delete-window nil))

(global-set-key (kbd "C-c o p") 'windmove-up)
(global-set-key (kbd "C-c o n") 'windmove-down)
(global-set-key (kbd "C-c o f") 'windmove-right)
(global-set-key (kbd "C-c o b") 'windmove-left)
(global-set-key (kbd "C-c o k") 'kill-this-buffer-and-delete-window)
