(add-hook 'vterm-mode-hook
          (lambda ()
            (display-line-numbers-mode -1)
            (compilation-shell-minor-mode)))
(setq vterm-buffer-name-string "*vterm [%s]*")
(setq vterm-term-environment-variable "xterm-256color")
