;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'sc-flex)

(defun sc-frames--mk-sbt-project (root-dir frame-name)
  "Make a frame for project in ROOT-DIR with FRAME-NAME ready for SBT development."
  (interactive)
  (let ((frame '(make-frame ((name . frame-name))))
        (build-file (concat root-dir "build.sbt")))
    (progn
      (delete-other-windows)
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


(defun sc-frames-mk-dashboard ()
  "Make frames with workday dashboard."
  (interactive)
  (progn
    (org-agenda)
    (delete-other-windows)
    (sc-flex-tail-prod)
    (split-window-below)
    (switch-to-buffer org-agenda-buffer-name)
    (split-window-right)
    (mu4e)))

;; Our frames all start with the C-c C-f keybinding

(global-set-key (kbd "C-c C-f d") 'sc-frames-mk-dashboard)
(global-set-key (kbd "C-c C-f s") 'sc-frames-mk-toolkit)
(global-set-key (kbd "C-c C-f f") 'sc-frames-mk-flex)

(provide 'sc-frames)
;;; sc-frames.el ends here
