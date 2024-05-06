;;; Code:
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(setq my--font (concat "Source Code Pro"
                       (pcase system-name
                         ("fm-mbp" "-9")
                         ("lab-mbp-miyachi.local" "-12")
                         ("fm-pc" "-9")
                         (_ "9"))))
(push `(font . ,my--font) default-frame-alist)
;(setq-default line-spacing 0.1)
(when (eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(height . 58))
  (add-to-list 'default-frame-alist '(width . 142)))
;;;
