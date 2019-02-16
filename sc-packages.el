;;; package --- Summary
;;; Commentary:
;;; Code:

(require 'package)
(require 'use-package)

(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing.  Install it? " package))
           (package-install package))))
 '(use-package))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Enable defer and ensure by default for use-package
(setq use-package-always-defer t
      use-package-always-ensure t)

(use-package ace-jump-mode)
(use-package define-word)
(use-package eshell-git-prompt
  :config
  (eshell-git-prompt-use-theme 'powerline))
(use-package expand-region)
(use-package fill-column-indicator)
(use-package js2-mode
  :hook (js2-mode . sc-prog-mode)
  :config
  (setq js2-mode-basic-offset 2)
  (setq auto-mode-alist
        (cons
         '("\\.js$" . js2-mode)
         auto-mode-alist)))
(use-package helm-ag)
(use-package magit)
(use-package markdown-mode
  :hook (markdown-mode . flyspell-mode)
  :config
  (setq auto-mode-alist
        (cons
         '("\\.md$" . markdown-mode)
         auto-mode-alist)))
(use-package multi-term)
(use-package paredit)
(use-package popup-imenu)
(use-package projectile
  :demand t
  :config
  (projectile-global-mode t)
  (defadvice projectile-project-root (around ignore-remote first activate)
    (unless (file-remote-p default-directory) ad-do-it))
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map))
(use-package rainbow-mode)
(use-package undo-tree
  :demand t
  :config
  (global-undo-tree-mode))
(use-package web-mode
  :hook (web-mode . sc-prog-mode)
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode)))
(use-package which-key)
(use-package xclip)
(use-package yasnippet
  :demand t
  :config
  (yas-global-mode t)
  (setq yas-snippet-dirs '("~/emacs.git/snippets")))
(use-package zenburn-theme
  :demand t
  :after
  (load-theme 'zenburn t))

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode)

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(define-minor-mode sc-prog-mode
  "General programming setup that all programming buffers should enable."
  :init-value nil
  (display-line-numbers-mode)
  (which-key-mode)
  (rainbow-mode)
  (show-paren-mode)
  (electric-pair-mode)
  (fci-mode)
  (hl-line-mode)
  (whitespace-mode)
  (company-mode))


;; Programming languages

(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$"
  :preface
  (require 'sc-enhance-scala-mode)
  :hook ((scala-mode . sc-prog-mode)
         (scala-mode . subword-mode)
         (scala-mode . sc-scala-set-local-keys))
  :config
  (add-hook 'scala-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'lsp-format-buffer nil 'make-it-local)))
  )

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (set-variable 'sbt:program-name "/usr/bin/sbt")
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

(use-package lsp-scala
  :after scala-mode
  :demand t
  :hook (scala-mode . lsp))

(use-package company-lsp
  :after
  (push 'company-lsp company-backends))

(provide 'sc-packages)
;;; sc-packages ends here
