;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(add-hook 'after-init-hook (lambda () (load "~/emacs.git/init.el")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(css-indent-offset 2)
 '(custom-safe-themes
   '("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default))
 '(elfeed-feeds '("https://reddit.com/r/emacs/.rss"))
 '(fci-rule-column 120)
 '(fci-rule-width 2)
 '(global-undo-tree-mode t)
 '(inhibit-startup-screen t)
 '(ispell-dictionary nil)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(linum-format 'dynamic)
 '(logview-additional-level-mappings
   '(("Journalctl"
      (error "ERROR")
      (warning "WARN")
      (information "INFO")
      (debug "DEBUG")
      (trace "   [ State ]: EDITED, shown value does not take effect until you set or save it.")
      (aliases))))
 '(markdown-command "batcat")
 '(markdown-css-paths
   '("https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css"))
 '(mu4e-compose-dont-reply-to-self t)
 '(mu4e-headers-fields
   '((:human-date . 12)
     (:maildir . 10)
     (:from . 22)
     (:subject)))
 '(mu4e-maildir "~/mail" t)
 '(mu4e-sent-messages-behavior 'delete)
 '(org-agenda-custom-commands
   '(("n" "Agenda and all TODO's"
      ((agenda "" nil)
       (alltodo "" nil))
      nil)
     ("x" "Started TODOs" todo "STARTED" nil)))
 '(org-agenda-files
   '("/home/markschaake/Dropbox/org/gtd/code-club.org" "/home/markschaake/Dropbox/org/gtd/flex.org" "/home/markschaake/Dropbox/org/gtd/gtd.org" "/home/markschaake/Dropbox/org/gtd/journal.org" "/home/markschaake/Dropbox/org/gtd/mark-capital.org" "/home/markschaake/Dropbox/org/gtd/personal.org" "/home/markschaake/Dropbox/org/gtd/schedule.org" "/home/markschaake/Dropbox/org/gtd/someday.org" "/home/markschaake/Dropbox/org/gtd/woodworking.org" "/home/markschaake/Dropbox/org/gtd/schaake-brewing-company.org"))
 '(org-capture-templates
   '(("m" "Mark Capital Task" entry
      (file+headline "~/Dropbox/org/gtd/mark-capital.org" "Capture")
      (file "~/Dropbox/org/capture-templates/gtd-task.txt")
      :empty-lines-before 1)
     ("s" "FLEX Task" entry
      (file+headline "~/Dropbox/org/gtd/flex.org" "Capture")
      (file "~/Dropbox/org/capture-templates/gtd-task.txt")
      :empty-lines-before 1)
     ("p" "Personal Task" entry
      (file+headline "~/Dropbox/org/gtd/personal.org" "Capture")
      (file "~/Dropbox/org/capture-templates/gtd-task.txt")
      :empty-lines-before 1)))
 '(org-default-notes-file "~/Dropbox/org/gtd/journal.org")
 '(org-directory "~/Dropbox/org")
 '(org-log-done 'time)
 '(org-log-into-drawer t)
 '(org-refile-targets
   '(("~/Dropbox/org/gtd/gtd.org" :maxlevel . 1)
     ("~/Dropbox/org/gtd/someday.org" :maxlevel . 2)))
 '(package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(copilot which-key-posframe company lsp-pyright company-box editorconfig quelpa-use-package quelpa gptel dropbox multiple-cursors lsp-tailwindcss crontab-mode amx dired org all-the-icons-dired org-bullets yasnippet-snippets desktop-environment all-the-icons lsp-metals ag log4j-mode htmlize auto-package-update ox-reveal forge csv-mode docker cargo slime flymake-yaml yaml-mode company-restclient restclient-mode avy flyspell use-pakckage yasnippet sbt-mode scala-mode company-lsp lsp-ui lsp-mode flycheck define-word pdf-tools mu4e-alert zeal-at-point less-css-mode popup-imenu magit helm-ag exwm nginx-mode systemd expand-region thrift restclient which-key zenburn-theme xclip web-mode use-package undo-tree rainbow-mode projectile paredit multi-term markdown-mode js2-mode flymake-less fill-column-indicator eshell-git-prompt))
 '(pyvenv-workon "python-TihE9rGM")
 '(restclient-inhibit-cookies t)
 '(sbt:program-name "/usr/bin/sbt")
 '(sbt:program-options '("-Djline.terminal=none" "-Dsbt.supershell=false"))
 '(scala-mode-feature:electric-on-per-default t)
 '(scroll-bar-mode nil)
 '(sql-product 'postgres)
 '(tabbar-separator '(0.5))
 '(tramp-default-method "ssh")
 '(undo-tree-auto-save-history nil)
 '(use-package-always-defer t)
 '(use-package-always-ensure t)
 '(whitespace-style
   '(face trailing tabs lines-tail newline empty indentation space-after-tab space-before-tab tab-mark) t)
 '(yas-snippet-dirs
   '("/home/markschaake/.emacs.d/snippets" yasnippet-snippets-dir "/home/markschaake/emacs.git/snippets")))
 ;'(tramp-syntax (quote default))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
