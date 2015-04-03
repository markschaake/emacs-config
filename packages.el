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
 '(coffee-mode
   elscreen
   elscreen-separate-buffer-list
   flymake-coffee
   less-css-mode
   flymake-less
   ensime
   js2-mode
   magit
   markdown-mode
   multi-term
   paredit
   projectile
   rainbow-mode
   scala-mode2
   tabbar
   undo-tree
   web-mode
   yaml-mode
   yasnippet
   zenburn-theme))
                     
