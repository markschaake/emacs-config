;;; package --- Summary
;;; Commentary:
;;; Code:

(require 'package)
(add-to-list 'load-path "~/emacs.git/")

; Makes tab key in org babel source blocks work as expected for the language being edited.
(setq org-src-tab-acts-natively t)

(org-babel-load-file (expand-file-name "~/emacs.git/org-init.org"))
;(org-babel-load-file (expand-file-name "~/emacs-local/org-init.org"))

(provide 'init)
;;; init.el ends here
