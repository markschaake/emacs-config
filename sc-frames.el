;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'sc-flex)

(defun sc-windows--mk-sbt-project (root-dir)
  "Make windows in the current frame for project in ROOT-DIR ready for SBT development."
  (interactive)
  (let ((build-file (concat root-dir "build.sbt")))
    (progn
      (find-file root-dir)
      (sbt-start)
      (set-buffer (sbt:buffer-name))
      (text-scale-set -1)
      (split-window-below -12)
      (find-file build-file)
      (magit-status)
      (let ((mbuf (buffer-name)))
        (progn
          (delete-window)
          (split-window-right)
          (windmove-right)
          (message (concat "Magit buffer: " mbuf))
          (switch-to-buffer mbuf)
          (windmove-down))))))

(defun sc-frames--mk-sbt-project (root-dir frame-name)
  "Make a frame for project in ROOT-DIR with FRAME-NAME ready for SBT development."
  (interactive)
  (let ((frame '(make-frame ((name . frame-name)))))
    (progn
      (delete-other-windows)
      (sc-windows--mk-sbt-project root-dir)
      )))

(defun sc-frames-mk-toolkit ()
  "Make frame ready for ss-toolkit development."
  (interactive)
  (progn
    (sc-frames--mk-sbt-project "/home/markschaake/projects/ss-toolkit/" "ss-toolkit")
    (sbt-command "project schaake-test-server")))

(defun sc-frames-mk-flex ()
  "Make frame ready for FLEX development."
  (interactive)
  (progn
    (sc-frames--mk-sbt-project "/home/markschaake/projects/flex/" "flex")
    (sbt-command "project flex-server")))

(defun sc-frames-mk-sbt-plugins ()
  "Make frame ready for sc-sbt-plugins development."
  (interactive)
  (progn
    (sc-frames--mk-sbt-project "/home/markschaake/projects/sc-sbt-plugins/" "sc-sbt-plugins")
    ))

(defun sc-frames-mk-servicepro ()
  "Make frame ready for servicepro.management development."
  (interactive)
  (progn
    (sc-frames--mk-sbt-project "/home/markschaake/projects/servicepro/" "servicepro")
    ))

(defun sc-frames-mk-homeschool ()
  "Make frame ready for Schaake Homeschool development."
  (interactive)
  (progn
    (sc-frames--mk-sbt-project "/home/markschaake/projects/schaake-homeschool/" "schaake-homeschool")
    (sbt-command "project server")))


(defun sc-frames-mk-dashboard ()
  "Make frames with workday dashboard."
  (interactive)
  (let ((plan-file "/home/markschaake/Dropbox/org/gtd/dailyplan.org"))
    (progn
      (find-file plan-file)
                                        ;(org-agenda)
      (delete-other-windows)
      (sc-flex-tail-prod)
      (split-window-below)
      (switch-to-buffer "dailyplan.org")
                                        ;(switch-to-buffer org-agenda-buffer-name)
      (split-window-right)
      (mu4e))))

(defun sc-windows-mk-toolkit ()
  "Make frame ready for ss-toolkit development."
  (interactive)
  (progn
    (sc-windows--mk-sbt-project "/home/markschaake/projects/ss-toolkit/")
    (sbt-command "project schaake-test-server")))

(defun sc-windows-mk-flex ()
  "Make frame ready for FLEX development."
  (interactive)
  (progn
    (sc-windows--mk-sbt-project "/home/markschaake/projects/flex/")
    (sbt-command "project flex-server")))

(defun sc-windows-mk-sbt-plugins ()
  "Make frame ready for sc-sbt-plugins development."
  (interactive)
  (progn
    (sc-windows--mk-sbt-project "/home/markschaake/projects/sc-sbt-plugins/")
    ))

(defun sc-windows-mk-servicepro ()
  "Make frame ready for servicepro.management development."
  (interactive)
  (progn
    (sc-windows--mk-sbt-project "/home/markschaake/projects/servicepro/")
    ))

(defun sc-windows-mk-homeschool ()
  "Make frame ready for Schaake Homeschool development."
  (interactive)
  (progn
    (sc-windows--mk-sbt-project "/home/markschaake/projects/schaake-homeschool/")
    (sbt-command "project server")))


(defun sc-windows-mk-dashboard ()
  "Make frames with workday dashboard."
  (interactive)
  (let ((plan-file "/home/markschaake/Dropbox/org/gtd/dailyplan.org"))
    (progn
      (find-file plan-file)
      (split-window-right)
      (windmove-right)
      (sc-flex-tail-prod)
      (windmove-left)
      (split-window-below -15)
      (mu4e))))

(defun sc-windows-mk-mc ()
  "Make frames with Mark Capital browser windows."
  (interactive)
  (progn
    (split-window-right)
    (windmove-right)))


(defun sc-frames--kill-sbt ()
  "Stop metals and kill all project files."
  (interactive)
  (progn
    (lsp-shutdown-workspace)
    (projectile-kill-buffers)))

;; Our frames all start with the C-c f keybinding

(global-set-key (kbd "C-c f d") 'sc-frames-mk-dashboard)
(global-set-key (kbd "C-c f s") 'sc-frames-mk-toolkit)
(global-set-key (kbd "C-c f f") 'sc-frames-mk-flex)
(global-set-key (kbd "C-c f p") 'sc-frames-mk-sbt-plugins)
(global-set-key (kbd "C-c f h") 'sc-frames-mk-homeschool)
(global-set-key (kbd "C-c f m") 'sc-frames-mk-servicepro)

(global-set-key (kbd "C-c w d") 'sc-windows-mk-dashboard)
(global-set-key (kbd "C-c w s") 'sc-windows-mk-toolkit)
(global-set-key (kbd "C-c w f") 'sc-windows-mk-flex)
(global-set-key (kbd "C-c w p") 'sc-windows-mk-sbt-plugins)
(global-set-key (kbd "C-c w h") 'sc-windows-mk-homeschool)
(global-set-key (kbd "C-c w m") 'sc-windows-mk-servicepro)

(global-set-key (kbd "C-c f k s") 'sc-frames--kill-sbt)

(provide 'sc-frames)
;;; sc-frames.el ends here
