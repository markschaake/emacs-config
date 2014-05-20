(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; make sure all packages are loaded
(load-file "~/emacs.git/packages.el")

(add-to-list 'load-path "~/emacs.git/local/")

(set-register ?e '(file . "~/emacs.git/.emacs"))

(set-register ?i '(file . "~/emacs.git/init.el"))

;; tabs and whitespace
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq whitespace-line-column 120)
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
(add-hook 'html-mode-hook 'skewer-html-mode)

;; Javascript indent to 2
(setq js2-mode-basic-offset 2)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'js2-mode-hook 'editing-setup)

;; CSS indent to 2
(add-hook 'css-mode-hook 'editing-setup)
(add-hook 'css-mode-hook 'skewer-css-mode)

;; Dash
(autoload 'dash-at-point "dash-at-point"
	"Search the word at point with Dash." t nil)
(add-to-list 'dash-at-point-mode-alist '(scala-mode . "scala"))
(add-to-list 'dash-at-point-mode-alist '(less-css-mode . "css"))
(add-to-list 'dash-at-point-mode-alist '(html-mode . "html"))
(add-to-list 'dash-at-point-mode-alist '(coffee-mode . "coffee"))
(global-set-key "\C-cd" 'dash-at-point)

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
(require 'flymake-less)
(defun less-custom ()
  "less-css-mode-hook"
  (set (make-local-variable 'tab-width) 2)
  (editing-setup))
(add-hook 'less-css-mode-hook 'flymake-less-load)
(add-hook 'less-css-mode-hook '(lambda() (less-custom)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(inhibit-startup-screen t)
 '(projectile-global-mode t)
 '(scala-mode-feature:electric-on-per-default t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
