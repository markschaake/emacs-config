(require 'package)
(require 'use-package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(package-initialize)

(use-package ensime
  :ensure t
  :pin melpa-stable)

(when (not package-archive-contents)
  (package-refresh-contents))

(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package)) 
           (package-install package))))
 '(ace-jump-mode
   less-css-mode
   flymake-less
   elscreen
   eshell-git-prompt
   expand-region
   fill-column-indicator
   js2-mode
   helm-ag
   magit
   markdown-mode
   multi-term
   paredit
   popup-imenu
   projectile
   rainbow-mode
   tabbar
   undo-tree
   use-package
   web-mode
   which-key
   xclip
   zenburn-theme))
                     
