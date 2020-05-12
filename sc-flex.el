;;; package --- Summary
;;; Commentary:
;;; Code:
(defvar sc-flex--root-dir "/home/markschaake/projects/flex/")
(defvar sc-flex--tail-file (concat sc-flex--root-dir "prod.log"))
(defvar sc-flex--scripts-dir (concat sc-flex--root-dir "scripts/"))

(defun sc-flex-tail-prod ()
  "Tail the prod journalctl log."
  (interactive)
  ;; spawn a process that tails the journal and appends to the log file
  (progn
    (set-process-sentinel
     (start-process "sc-flex-tail-prod" "*sc-flex-tail-prod*" (concat sc-flex--scripts-dir "flex-tail-to-file.sh") sc-flex--tail-file)
     '(lambda (proc evt)
        (progn
          (message (concat "Got event: " evt))
          (when (not (= 0 (process-exit-status proc)))
            (start-process "sc-flex-tail-prod" "*sc-flex-tail-prod*" "echo" "[ERROR] CONNECTION LOST" ">>" sc-flex--tail-file)))
        ))
    (find-file sc-flex--tail-file)
    (text-scale-set -2)))

(provide 'sc-flex)
;;; sc-flex.el ends here
