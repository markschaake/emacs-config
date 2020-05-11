;;; package --- Summary
;;; Commentary:
;;; Code:

(defvar sc-mark-capital-scan-title-front-filename nil
  "File name to save front side of title.")
(make-variable-buffer-local 'sc-mark-capital-scan-title-front-filename)

(defvar sc-mark-capital-scan-title-back-filename nil
  "File name to save back side of title.")
(make-variable-buffer-local 'sc-mark-capital-scan-title-back-filename)

(defvar sc-mark-capital-scan-title-out-filename nil
  "File name to save merged title PDF.")
(make-variable-buffer-local 'sc-mark-capital-scan-title-out-filename)

(defun sc-mark-capital-scan-title ()
  "Scan a title from the Brother printer."
  (interactive)
  (let* ((contract (read-string "Contract number: "))
         (vin_last_four (read-string "VIN last 4: "))
         (dest_dir "/home/markschaake/companies/mark-capital-finance/title-scans/")
         (file_prefix (concat dest_dir contract "_" vin_last_four "_title")))
    (progn
      (message "Out file: %s" sc-mark-capital-scan-title-out-filename)
      (message "Will scan front of title now...")
      (setq sc-mark-capital-scan-title-front-filename (concat file_prefix "_front.pdf"))
      (setq sc-mark-capital-scan-title-back-filename (concat file_prefix "_back.pdf"))
      (setq sc-mark-capital-scan-title-out-filename (concat file_prefix ".pdf"))
      (set-process-sentinel
       (start-process "mc-scan-title" "*mc-scan-title*" "/home/markschaake/bin/scan-to-file.sh" sc-mark-capital-scan-title-front-filename)
       '(lambda (process event)
          (when (= 0 (process-exit-status process))
              (if (y-or-n-p "Scan back side of title? ")
                  (set-process-sentinel
                   (start-process "mc-scan-title" "*mc-scan-title*" "/home/markschaake/bin/scan-to-file.sh" sc-mark-capital-scan-title-back-filename)
                   '(lambda (process event)
                      (when (= 0 (process-exit-status process))
                        (set-process-sentinel
                         (start-process
                          "mc-scan-title"
                          "*mc-scan-title*"
                          "pdfunite"
                          sc-mark-capital-scan-title-front-filename
                          sc-mark-capital-scan-title-back-filename
                          sc-mark-capital-scan-title-out-filename)
                         '(lambda (process event)
                            (when (= 0 (process-exit-status process))
                              (progn
                                (message (concat "Title scan completed: " sc-mark-capital-scan-title-out-filename))
                              (delete-file sc-mark-capital-scan-title-front-filename)
                              (delete-file sc-mark-capital-scan-title-back-filename)
                              ))
                            ))))))))
          ))))

(defun sc-mark-capital-scan-to-file ()
  "Scan a title from the Brother printer."
  (interactive)
  (let* ((file_name (read-string "File name: "))
         (dest_dir "/home/markschaake/companies/mark-capital-finance/scans/")
         (out_file (concat dest_dir file_name)))
    (progn
      (set-process-sentinel
       (start-process "scan-to-file" "*scan-to-file*" "/home/markschaake/bin/scan-to-file.sh" out_file)
       '(lambda (process event)
          (if (string= "finished\n" event)
              (message "FINISHED!")
            (message "NOT FINISHED!"))))
      (message (concat "Scanning file to " out_file))
      )))


;; Mark Capital
(global-set-key (kbd "C-c C-m t") 'sc-mark-capital-scan-title)
(global-set-key (kbd "C-c C-m s") 'sc-mark-capital-scan-to-file)

(provide 'sc-mark-capital)
;;; sc-mark-capital.el ends here
