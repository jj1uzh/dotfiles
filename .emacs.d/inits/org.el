(visual-line-mode t)
(require 'ox-latex)
(require 'ox-beamer)
(with-eval-after-load 'ox-latex
  (setq skk-kutoten-type 'en)
  (setq org-latex-pdf-process '("latexmk -pdfdvi %f"))
  (add-to-list 'org-latex-classes
	           '("ujarticle"
		         "\\documentclass[11px]{ujarticle}"
		         ("\\section{%s}" . "\\section*{%s}")
		         ("\\subsection{%s}" . "\\subsection*{%s}")
		         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		         ("\\paragraph{%s}" . "\\paragraph*{%s}")
		         ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
               '("beamer"
                 "\\documentclass[dvipdfmx,11pt,t]{beamer}
                              [NO-DEFAULT-PACKAGES] [PACKAGES] [EXTRA]"
                 ("\\section\{%s\}" . "\\section*\{%s\}")
                 ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
                 ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
  (setq org-latex-default-class "ujarticle")
  (setq org-latex-with-hyperref nil))

(defun my/org-insert-uri-image (uri action)
  (if (not (eq major-mode 'org-mode))
      (dnd-open-file uri action)
    (require 'request)
    (request uri
      :encoding 'binary
      :complete (cl-function
                 (lambda (&key data response &allow-other-keys)
                   (let* ((ext (pcase (request-response-header response "content-type")
                                 ("image/jpeg" ".jpeg")
                                 ("image/png" ".png")
                                 (typ "")))
                          (fname (format "./%s%s"
                                         (format-time-string "%Y-%m-%d_%H-%M-%S"
                                                             (current-time))
                                         ext)))
                     (with-temp-buffer
                       (insert data)
                       (write-region nil nil fname))
                     (insert (format "[[%s]]" fname))))))))

(push '("^\\(https?\\)://" . my/org-insert-uri-image) dnd-protocol-alist)
