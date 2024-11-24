(setq eshell-prompt-function
      (lambda () (concat "\n"
                         (number-to-string eshell-last-command-status)
                         " [" (user-login-name) "@" (system-name) " " (eshell/pwd) "]\n> ")))

(setq eshell-prompt-regexp "^[^>]*> ")
