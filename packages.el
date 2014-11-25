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
   scala-mode2
   tabbar
   web-mode
   yaml-mode
   yasnippet
   zenburn-theme))
                     
