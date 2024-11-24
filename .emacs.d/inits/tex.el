(setq TeX-parse-self t)
;(setq japanese-TeX-engine-default 'uptex)
(setq japanese-LaTeX-default-style "bxjsarticle")
(setq TeX-default-mode 'japanese-latex-mode)
(setq TeX-engine 'uptex)
(setq TeX-PDF-from-DVI "Dvipdfmx")
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(setq TeX-source-correlate-mode t)
(setq TeX-math-toggle-off-input-method nil)
(setq TeX-electric-math '("$" . "$"))
(setq-default TeX-master "master")

(setq preview-gs-command "/opt/homebrew/bin/gs")
(setq preview-fast-dvips-command "dvips -Ppdf %d -o %m/preview.ps")
(setq preview-dvips-command "dvips -Ppdf -i -E %d -o %m/preview.000")
(setq preview-scale-function 0.8)

(add-to-list 'TeX-style-path (expand-file-name "~/.latex"))
(setenv "TEXINPUTS" (concat (getenv "TEXINPUTS") (expand-file-name "~/.latex") ":"))

(add-hook 'TeX-mode-hook
          (lambda ()
            (prettify-symbols-mode 1)))

(add-hook 'LaTeX-mode-hook
          (lambda()
            (require 'company-reftex)
            (LaTeX-math-mode)
            (turn-on-reftex)
            (make-local-variable 'company-backends)
            (add-to-list 'company-backends 'company-reftex-labels)
            (add-to-list 'company-backends 'company-reftex-citations)))

;; (defun my/tex-setup ()
;;   (interactive)
;;   (unless (string-suffix-p ".tex" (buffer-name))
;;     (error "Not a TeX file buffer"))
;;   (ignore-errors (server-start))
;;   ;; (let ((texname (buffer-name)))
;;   ;;   (with-current-buffer (vterm-other-window)
;;   ;;     (vterm-insert (concat "latexmk -pvc -pdfdvi "
;;   ;;                           texname))
;;   ;;     (vterm-send-return))
;;   ;;   (string-match "\\.tex$" texname)
;;   ;;   (let ((pdfname (replace-match ".pdf" t nil texname)))
;;   ;;     (shell-command (concat "open -a Skim build/"
;;   ;;                            pdfname)))))
;;   )
