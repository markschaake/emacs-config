;; make sure all packages are loaded
(load-file "~/emacs.git/packages.el")

(add-to-list 'load-path "~/emacs.git/local/")

(set-register ?e '(file . "~/emacs.git/.emacs"))

(set-register ?i '(file . "~/emacs.git/init.el"))

(set-register ?g '(file . "~/Dropbox/org/gtd/gtd.org"))

(winner-mode t)

(set-variable 'sbt:program-name "/usr/local/bin/sbt")

(when window-system
  (speedbar t))

(global-git-gutter+-mode t)

;; org-mode global key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-set-key "\C-t" 'multi-term)
;(setq org-default-notes-file (concat org-directory "~/Dropbox/notes.org"))

;; tabs and whitespace
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq whitespace-line-column 100)
(global-set-key (kbd "C-c C-c") 'whitespace-cleanup)
(global-set-key (kbd "C-j") 'newline-and-indent)
(setq sh-basic-offset 2 sh-indentation 2)

;; buffers
;; revert buffers when changed externally (like git checkout)
(global-auto-revert-mode t)
;; save backup and temp files in /temp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; color theme
(load-theme 'zenburn t)

;; turn off the toolbar for GUI emacs
(tool-bar-mode -1)

;; ace-jump-mode key binding
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; turn on ido mode for awesome interactive stuff
(ido-mode t)
(setq ido-enable-flex-matching t)

;; turn on projectile globally
(projectile-global-mode t)

;; use undo-tree
(global-undo-tree-mode)

;; Local customizations

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
  ;(linum-mode)
  (whitespace-mode)
  )

;; web-mode
(defun my-web-mode-hook ()
  "Hooks for web-mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (editing-setup)
)
(add-hook 'web-mode-hook 'my-web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))

;; Javascript indent to 2
(setq js2-mode-basic-offset 2)
(add-hook 'js2-mode-hook 'editing-setup)

;; Scala
(defun scala-loader ()
	"Loads all scala stuff"
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

(add-hook 'comint-mode-hook
          (lambda ()
            (define-key comint-mode-map "\C-w" 'comint-kill-region)
            (define-key comint-mode-map [C-S-backspace]
              'comint-kill-whole-line)))

(scala-loader)

;; LESS CSS
(defun less-custom ()
  "less-css-mode-hook"
  (set (make-local-variable 'tab-width) 2)
  (editing-setup))
(add-hook 'less-css-mode-hook 'flymake-less-load)
(add-hook 'less-css-mode-hook '(lambda() (less-custom)))

;; eshell tab-completion
(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))

;; load any local overrides
(load-file "~/emacs-local/init.el")
