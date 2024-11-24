;; initialisation of package (if needed)
(package-initialize)

;; install quelpa
(use-package quelpa
  :ensure t)

(require 'quelpa)

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))

(require 'quelpa-use-package)

;; install dependencies
;; (use-package lsp-mode
;;   :ensure t)
;; (use-package session-async
;;   :ensure t)

;; the various required packages
(use-package isar-mode
  :ensure t
  :quelpa (isar-mode :fetcher github
		     :repo "m-fleury/isar-mode"
		     :files ("*.el")
		     :upgrade t))

(use-package isar-goal-mode
  :ensure t
  :quelpa (isar-goal-mode :fetcher github
			  :repo "m-fleury/simp-isar-mode"
		     :files ("*.el")
		     :upgrade t))

(use-package lsp-isar
	     :ensure t
	     :quelpa ((lsp-isar :fetcher github
				:repo "m-fleury/isabelle-emacs"
				:branch "isabelle2022-more-vscode"
				:files ("src/Tools/emacs-lsp/lsp-isar/*.el"))
				:upgrade t)
  :after lsp-mode
  :commands lsp-isar-define-client-and-start
  :defer t
  :init
  (add-hook 'isar-mode-hook #'lsp-isar-define-client-and-start)
  (add-hook 'lsp-isar-init-hook 'lsp-isar-open-output-and-progress-right-spacemacs)
  :config

  ;; CHANGE HERE: path to isabelle-emacs repo
  (setq lsp-isar-path-to-isabelle (concat user-emacs-directory "site-lisp/isabelle-emacs")))
