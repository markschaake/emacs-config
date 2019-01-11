(require 'package)
(require 'use-package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

;; Enable defer and ensure by default for use-package
;; (setq use-package-always-defer t
;;       use-package-always-ensure t)

(use-package ensime
  :ensure t
  :pin melpa-stable)
;; ;; Enable scala-mode and sbt-mode
;; (use-package scala-mode
;;   :mode "\\.s\\(cala\\|bt\\)$")

;; (use-package sbt-mode
;;   :commands sbt-start sbt-command
;;   :config
;;   ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
;;   ;; allows using SPACE when in the minibuffer
;;   (substitute-key-definition
;;    'minibuffer-complete-word
;;    'self-insert-command
;;    minibuffer-local-completion-map))

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

;; (use-package lsp-mode
;;   :pin melpa-stable)

;; (use-package lsp-ui
;;   :pin melpa-stable
;;   :hook (lsp-mode . lsp-ui-mode))

;; (use-package lsp-scala
;;   :load-path "~/opt/lsp-scala"
;;   :after scala-mode
;;   :demand t
;;   :hook (scala-mode . lsp-scala-enable))


(when (not package-archive-contents)
  (package-refresh-contents))

(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package))))
 '(ace-jump-mode
   define-word
   elscreen
   eshell-git-prompt
   expand-region
   fill-column-indicator
   flycheck
   js2-mode
   helm-ag
   lsp-mode
   lsp-ui
   magit
   markdown-mode
   multi-term
   paredit
   popup-imenu
   projectile
   rainbow-mode
   sbt-mode
   tabbar
   undo-tree
   use-package
   web-mode
   which-key
   xclip
   zenburn-theme))
