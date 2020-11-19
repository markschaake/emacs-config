;;; package --- Summary
;;; Commentary:
;;; Code:

(when (not package-archive-contents)
  (package-refresh-contents))

(require 'package)
(package-install 'use-package)
(require 'use-package)

(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing.  Install it? " package))
           (package-install package))))
 '(use-package))

;; Auto-update all packages on startup
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; Enable defer and ensure by default for use-package
(setq use-package-always-defer t
      use-package-always-ensure t)
(use-package ag
  :ensure t)
(use-package thrift)
(use-package avy)
(use-package define-word)
(use-package eshell-git-prompt
  :config
  (eshell-git-prompt-use-theme 'powerline))
(use-package expand-region)

(use-package js2-mode
  :hook (js2-mode . sc-prog-mode)
  :config
  (setq js2-mode-basic-offset 2)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))
(use-package helm-ag)
(use-package magit)
(use-package forge
  :config
  (setq ghub-use-workaround-for-emacs-bug nil)
  :after magit)
(use-package markdown-mode
  :hook (markdown-mode . flyspell-mode)
  :config
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))
(use-package log4j-mode
  :ensure t)
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
  (add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode)))

(use-package company-restclient
  :demand t
  :config
  (push 'company-restclient company-backends))

(use-package slime
  :hook (slime-mode . sc-prog-mode)
  :config
  (setq inferior-lisp-program "sbcl"))


(use-package restclient
  :hook (restclient-mode . company-mode)
  :config
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
  :config
  (load-theme 'zenburn t))

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  :init (setq lsp-prefer-flymake nil)
  :hook ((scala-mode . lsp)
         (rust-mode . lsp))
  :config (add-hook 'before-save-hook 'lsp-format-buffer nil 'make-it-local))

;; Add metals backend for lsp-mode
(use-package lsp-metals)

;; Python
;(use-package pyenv-mode)
;(use-package elpy
;  :ensure t
;  :init
;  (elpy-enable))

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
  :mode "\\.s\\(cala\\|bt\\|c\\)$"
  :preface
  (require 'sc-enhance-scala-mode)
  :hook ((scala-mode . sc-prog-mode)
         (scala-mode . subword-mode)
         (scala-mode . sc-scala-set-local-keys))
  :config
  (add-hook 'scala-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'lsp-format-buffer nil 'make-it-local)))
  )

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  (set-variable 'sbt:program-name "/usr/bin/sbt"))

(use-package company-lsp
  :config
  (push 'company-lsp company-backends))

(use-package cargo)
(use-package rust-mode
  :mode "\\.rs\\'"
  :demand t
  :hook (rust-mode . sc-prog-mode)
  :config
  (setq rust-indent-offset 2))

;; Support for reveal.js backend for org-mode presentations
(use-package ox-reveal
  :after org-mode)
(use-package htmlize)

(provide 'sc-packages)
;;; sc-packages ends here
