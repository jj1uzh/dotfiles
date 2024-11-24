(defmacro fn-ignore-errors (&rest body)
  `(lambda () (ignore-errors ,@body)))

(add-hook 'go-mode-hook
          (lambda () (add-hook 'before-save-hook (fn-ignore-errors (eglot-format-buffer)) nil :local)))
