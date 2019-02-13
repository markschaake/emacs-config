;;; package --- Summary
;;; Commentary:
;;; Code:

(add-to-list 'load-path "~/emacs.git/")

(require 'sc-packages)
(require 'sc-windows)
(require 'sc-key-bindings)

;; load any local overrides
(load-file "~/emacs-local/init.el")

;; Allows yanked text to copy to clipboard (is this only needed on a mac?)
(xclip-mode 1)

(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")))

(set-register ?i '(file . "~/emacs.git/init.el"))

(winner-mode t)

;; prevent ediff to open multiple frames which is busted for some reason
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (sql-set-product 'postgres)
            (toggle-truncate-lines t)))

;; tabs and whitespace
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq whitespace-line-column 120)
(setq whitespace-style '(face tabs trailing lines-tail space-before-tab newline indentation empty space-after-tab tab-mark newline-mark))
(setq sh-basic-offset 2 sh-indentation 2)

;; buffers
;; revert buffers when changed externally (like git checkout)
(global-auto-revert-mode t)
;; save backup and temp files in /temp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; turn off the toolbar for GUI emacs
(tool-bar-mode -1)

;; turn on ido mode for awesome interactive stuff
(ido-mode t)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

;; eshell tab-completion
(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))

;; elisp setup
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            ;; Use spaces, not tabs.
            (setq indent-tabs-mode nil)
            (company-mode)
            ;; Pretty-print eval'd expressions.
            (define-key emacs-lisp-mode-map
              "\C-x\C-e" 'pp-eval-last-sexp)
            ;; Recompile if .elc exists.
            (add-hook (make-local-variable 'after-save-hook)
                      (lambda ()
                        (byte-force-recompile default-directory)))
            (define-key emacs-lisp-mode-map
              "\r" 'reindent-then-newline-and-indent)))
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'sc-prog-mode)

;; Built-in prog modes
(add-hook 'nxml-mode-hook
          (lambda ()
            (sc-prog-mode)))

(provide 'init)
;;; init.el ends here
