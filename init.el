;; make sure all packages are loaded
(load-file "~/emacs.git/packages.el")

(add-to-list 'load-path "~/emacs.git/local/")

(set-register ?e '(file . "~/emacs.git/.emacs"))

(set-register ?i '(file . "~/emacs.git/init.el"))

(set-register ?g '(file . "~/Dropbox/org/gtd.org"))

(winner-mode t)

;; org-mode global key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;(setq org-default-notes-file (concat org-directory "~/Dropbox/notes.org"))

;; tabs and whitespace
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq whitespace-line-column 100)
(global-set-key (kbd "C-c C-c") 'whitespace-cleanup)

;; buffers
;; revert buffers when changed externally (like git checkout)
(global-auto-revert-mode t)
;; turn off backup file creation
(setq make-backup-files nil)

;; color theme
(load-theme 'zenburn t)

;; turn off the toolbar for GUI emacs
(tool-bar-mode -1)

;; turn on ido mode for awesome interactive stuff
(ido-mode t)
(setq ido-enable-flex-matching t)

;; turn on projectile globally
(projectile-global-mode t)

;; Local customizations
;; tweak tabbar
(load-file "~/emacs.git/local/tabbar-tweaks.el")
;; windows
(load-file "~/emacs.git/local/windows.el")

(setq auto-mode-alist
      (cons
       '("\\.md$" . markdown-mode)
       auto-mode-alist))

(setq auto-mode-alist
      (cons
       '("\\.js$" . js2-mode)
       auto-mode-alist))

(defun editing-setup ()
  (linum-mode)
  (whitespace-mode))

;; HTML
(add-hook 'html-mode-hook 'editing-setup)

;; Javascript indent to 2
(setq js2-mode-basic-offset 2)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'js2-mode-hook 'editing-setup)

;; CSS indent to 2
(add-hook 'css-mode-hook 'editing-setup)

;; Scala
(defun scala-loader ()
	"Loads all scala stuff"
	(add-to-list 'load-path "~/emacs.git/vendor/ensime/elisp")
	(require 'scala-mode2)
	(require 'ensime)
	;; Ensime save hooks
	(setq ensime-source-buffer-saved-hook
				'(lambda ()
					 ;(ensime-refactor-organize-imports)
					 ;(ensime-format-source)
					 ))

	(add-hook 'scala-mode-hook
		'(lambda()
			(editing-setup)
      (subword-mode)
			(ensime-scala-mode-hook)
			(load-file "~/emacs.git/local/enhance-scala-mode.el")
			(ad-activate 'newline-and-indent)
			(electric-pair-mode))))

(scala-loader)

;; CoffeeScript custom tab width = 2
(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2)
	(local-set-key (kbd "C-j") 'coffee-newline-and-indent))
(add-hook 'coffee-mode-hook
	  '(lambda() (coffee-custom)))
(require 'flymake-coffee)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)

;; LESS CSS
;(require 'flymake-less)
(defun less-custom ()
  "less-css-mode-hook"
  (set (make-local-variable 'tab-width) 2)
  (editing-setup))
(add-hook 'less-css-mode-hook 'flymake-less-load)
(add-hook 'less-css-mode-hook '(lambda() (less-custom)))
