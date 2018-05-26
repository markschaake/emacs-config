
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-hook 'after-init-hook (lambda () (load "~/emacs.git/init.el")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(css-indent-offset 2)
 '(custom-safe-themes
   (quote
    ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(ensime-goto-test-config-defaults
   (quote
    (:test-class-names-fn ensime-goto-test--test-class-names :test-class-suffixes
                          ("Spec" "Specification" "Test" "Check")
                          :impl-class-name-fn ensime-goto-test--impl-class-name :impl-to-test-dir-fn ensime-goto-test--impl-to-test-dir :is-test-dir-fn ensime-goto-test--is-test-dir :test-template-fn ensime-goto-test--test-template-schaake-spec)))
 '(fci-rule-color "#383838")
 '(fci-rule-column 120)
 '(fci-rule-width 2)
 '(inhibit-startup-screen t)
 '(js2-basic-offset 2)
 '(linum-format (quote dynamic))
 '(org-agenda-custom-commands
   (quote
    (("n" "Agenda and all TODO's"
      ((agenda "" nil)
       (alltodo "" nil))
      nil)
     ("x" "Started TODOs" todo "STARTED" nil))))
 '(org-agenda-files (quote ("~/Dropbox/org/gtd/gtd.org")))
 '(org-capture-templates
   (quote
    (("t" "GTD Task" entry
      (file+headline "~/Dropbox/org/gtd/gtd.org" "Tasks")
      (file "~/Dropbox/org/capture-templates/gtd-task.txt")))))
 '(org-default-notes-file "~/Dropbox/org/gtd/journal.org")
 '(org-directory "~/Dropbox/org")
 '(org-refile-targets
   (quote
    (("~/Dropbox/org/gtd/gtd.org" :maxlevel . 1)
     ("~/Dropbox/org/gtd/someday.org" :maxlevel . 2))))
 '(package-selected-packages
   (quote
    (less-css-mode popup-imenu magit helm-ag exwm nginx-mode systemd expand-region thrift restclient which-key zenburn-theme xclip web-mode use-package undo-tree tabbar rainbow-mode projectile paredit multi-term markdown-mode js2-mode flymake-less fill-column-indicator eshell-git-prompt ensime elscreen ace-jump-mode)))
 '(restclient-inhibit-cookies t)
 '(scala-mode-feature:electric-on-per-default t)
 '(scroll-bar-mode nil)
 '(sql-product (quote postgres))
 '(tabbar-separator (quote (0.5)))
 '(tramp-default-method "ssh")
 '(tramp-syntax (quote default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3F3F3F" :foreground "#DCDCCC" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "nil" :family "Menlo"))))
 '(ensime-implicit-highlight ((t (:underline "light gray"))))
 '(hl-line ((t (:background "gray36"))))
 '(linum ((t (:background "#3F3F3F" :foreground "yellow")))))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
