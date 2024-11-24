(setq scala-indent:align-forms t)
(setq scala-indent:align-parameters t)

(defmacro fn-ignore-errors (&rest body)
  `(lambda () (ignore-errors ,@body)))

(add-hook 'scala-mode-hook
          (lambda () (add-hook 'before-save-hook (fn-ignore-errors (eglot-format-buffer)) nil :local)))
