(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-fancy slime-company))
(setq slime-company-completion 'fuzzy)
(setq slime-company-after-completion 'slime-company-just-one-space)
