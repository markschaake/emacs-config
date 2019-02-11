;;; package --- Summary
;;; Commentary:
;;; Code:

(global-set-key [remap dabbrev-expand] 'hippie-expand)
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "M-i") 'popup-imenu)
(global-set-key (kbd "M-I") 'helm-imenu-in-all-buffers)
(global-set-key (kbd "C-c C-h a p") 'helm-ag-project-root)
(global-set-key (kbd "C-c C-h a f") 'helm-ag-this-file)
(global-set-key (kbd "C-c C-h r") 'helm-resume)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key "\C-xg" 'magit-status)
(global-set-key "\C-xt" 'eshell)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-c C-SPC") 'ace-jump-mode)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(provide 'sc-key-bindings)
;;; sc-key-bindings.el ends here