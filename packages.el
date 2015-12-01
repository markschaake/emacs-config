(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

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
   ensime
   eshell-git-prompt
   fill-column-indicator
   js2-mode
   magit
   magit-gh-pulls
   markdown-mode
   multi-term
   paredit
   projectile
   rainbow-mode
   scala-mode2
   tabbar
   undo-tree
   web-mode
   xclip
   zenburn-theme))
                     
