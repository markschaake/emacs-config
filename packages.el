(package-initialize)
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package)) 
           (package-install package))))
 '(coffee-mode
   emmet-mode
   flymake-coffee
   less-css-mode
   flymake-less
   dash
   dash-at-point
   dired+
   ensime
   js2-mode
   magit
   markdown-mode
   multi-term
   paredit
   projectile
   scala-mode2
   skewer-mode
   skewer-less
   tabbar
   web-mode
   yaml-mode
   yasnippet
   zenburn-theme))
                     
