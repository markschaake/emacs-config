;; turn off the toolbar for GUI emacs
(tool-bar-mode -1)

;; turn off backup file creation
(setq make-backup-files nil)

(add-to-list 'load-path "~/emacs.git/local")

(setq auto-mode-alist (cons '("\\.md$" . markdown-mode) auto-mode-alist))

;; Local customizations
(load-file "~/emacs.git/local/windows.el")

(require 'package)
(package-initialize)

(add-to-list 'package-archives
						 '("marmalade" . "http://marmalade-repo.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Yasnippet
(require 'yasnippet)
(yas/global-mode 1)
(setq yas-trigger-key "C-c TAB")
(yas/load-directory "~/emacs.git/snippets")

(add-to-list 'load-path "~/emacs.git/vendor")
(require 'markdown-mode)

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
					 (ensime-format-source)
					 ))

	(add-hook 'scala-mode-hook
		'(lambda()
			(ensime-scala-mode-hook)
			(yas/minor-mode-on)
			(load-file "~/emacs.git/local/enhance-scala-mode.el")
			(ad-activate 'newline-and-indent)
			(electric-pair-mode))))

(scala-loader)

;; Clojure
(add-hook 'clojure-mode-hook 'paredit-mode)

;; system-wide indentation
(setq-default tab-width 2)

;; CoffeeScript custom tab width = 2
(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook
	  '(lambda() (coffee-custom)))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(scala-mode-feature:electric-on-per-default t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
