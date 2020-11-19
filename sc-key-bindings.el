;;; package --- Summary
;;; Commentary:
;;; Code:

(defun sc-eshell-new ()
  "Create a new eshell buffer."
  (interactive)
  (eshell "new-buffer"))

(global-set-key [remap dabbrev-expand] 'hippie-expand)
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "M-i") 'popup-imenu)
(global-set-key (kbd "M-I") 'helm-imenu-in-all-buffers)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key "\C-xg" 'magit-status)
(global-set-key "\C-xt" 'sc-eshell-new)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)

(provide 'sc-key-bindings)
;;; sc-key-bindings.el ends here
