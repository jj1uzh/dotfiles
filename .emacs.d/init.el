;; -*- lexical-binding:t -*-
;(profiler-start 'cpu)
(defvar-local gc-cons-threshold-default gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)

(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq make-backup-files nil)
(setq inhibit-startup-screen t)
(global-auto-revert-mode 1)
(setq auto-revert-avoid-polling t)
(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook #'delete-trailing-whitespace)
;(add-to-list 'display-buffer-alist '("*Async Shell Command*" display-buffer-no-window (nil)))
(setq-default tab-width 4)

(setq scroll-conservatively 101)
(setq scroll-margin 4)
(setq scroll-preserve-screen-position t)
(setq next-screen-context-lines 5)
(setq isearch-allow-scroll t)
(setq hscroll-step 1)
(setq hscroll-margin 1)

(add-to-list 'term-file-aliases
             '("screen-256color-bce" . "xterm-256color"))

(electric-pair-mode)
(add-hook 'isearch-mode-hook
          (lambda () (electric-pair-local-mode -1)))
(add-hook 'isearch-mode-end-hook
          (lambda () (electric-pair-local-mode 1)))

;;(defmacro set-scroll-margin-0 ()
;;  `(lambda () (set (make-local-variable 'scroll-margin) 0)))

(define-key key-translation-map [?\C-h] [?\C-?])
(define-key global-map (kbd "C-x O") (lambda () (interactive) (other-window -1)))

(xterm-mouse-mode 1)
(xclip-mode 1)

(mouse-wheel-mode 1)
(setq mouse-wheel-scroll-amount '(2 ((shift) . 5) ((meta)) ((control) . text-scale)))
(setq mouse-wheel-progressive-speed nil)

(dashboard-setup-startup-hook)
(setq dashboard-startup-banner 'official)
(define-key dashboard-mode-map (kbd "n") #'dashboard-next-line)
(define-key dashboard-mode-map (kbd "p") #'dashboard-previous-line)

(when (display-graphic-p)
  (load-theme 'wombat)
  (set-cursor-color "#dddddd")
  (blink-cursor-mode 0)
  (setq frame-title-format '("%b - Emacs"))
  (fringe-mode '(8 . 8))
  (set-frame-font my--font)
                                        ;  (set-fontset-font t 'japanese-jisx0208 my--font)
  (set-fontset-font t 'japanese-jisx0208 "Ricty Diminished Discord")
  (set-fontset-font t '(#x1F004 . #x1FFFD) "Noto Color Emoji-8"))
                                        ;  (add-hook 'prog-mode-hook #'hl-line-mode)
                                        ;  (add-hook 'text-mode-hook #'hl-line-mode))

(require 'package)
; (setq package-quickstart t)
;(add-to-list 'package-archives `("local" . ,(expand-file-name (concat user-emacs-directory "local-elpa/"))))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize t)

(define-key global-map (kbd "C-c r") #'recentf-open-files)
(setq recentf-max-saved-items 30)
(setq recentf-exclude '("/recentf" "/ido.last" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:"))
(recentf-mode)

;(evil-mode)
;; (add-hook 'change-major-mode-hook
;;           (lambda ()
;;             (unless (derived-mode-p 'prog-mode)
;;               (evil-emacs-state))))

(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(global-diff-hl-mode)
(diff-hl-flydiff-mode)
(global-company-mode)
(setq company-dabbrev-downcase nil)
(setq company-idle-delay 0.1)
(setq default-input-method "japanese-skk")

(setq compilation-scroll-output t)
(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook #'my-colorize-compilation-buffer))

; (package-install-file (concat user-emacs-directory "local-elpa/pdf-tools-1.0.0snapshot.tar"))
(pdf-loader-install)
; (add-to-list 'load-path (concat user-emacs-directory "site-lisp/emacs-scala-mode"))
(define-key global-map (kbd "C-c t") #'treemacs)

;; mu4e
(push (pcase system-type
               ("gnu/linux" "/usr/share/emacs/site-lisp/mu4e")
               (_ "/opt/homebrew/share/emacs/site-lisp/mu/mu4e"))
      load-path)
(autoload 'mu4e "mu4e" "" t)

;; dired
(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)
(setq dired-recursive-delqetes 'top)
(setq dired-isearch-filenames t)
(add-hook 'dired-mode-hook (lambda () (rename-buffer default-directory)))

;; c
(setq c-default-style '((other . "linux")))

;; scala-mode
(push (concat user-emacs-directory "site-list/" "emacs-scala-mode") load-path)
(autoload 'scala-mode "scala-mode")
(push '("\\.scala\\'" . scala-mode) auto-mode-alist)
(push '("\\.sbt\\'" . scala-mode) auto-mode-alist)

;; configuration files
(dolist (p '(pdf-tools scala-mode neo-tree eglot go-mode cc-mode js-mode vterm slime
             skk mu4e wc-mode org magit-log tex scala-mode treemacs eshell))
  (with-eval-after-load p
    (load-file (concat user-emacs-directory "inits/" (symbol-name p) ".el"))))

;; server
(ignore-errors
  (server-start))

;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-tab-line-mode nil)
 '(magit-log-margin '(t "%Y-%m-%d %H:%M:%S" magit-log-margin-width t 18))
 '(package-selected-packages
   '(typescript-mode prisma-ts-mode scala-mode xclip company-reftex rainbow-mode request evil htmlize eglot php-mode json-mode go-mode pdf-tools slime-company slime web-mode auctex company flycheck strace-mode csv-mode dashboard treemacs-magit vterm magit docker-compose-mode nginx-mode eldoc treemacs company-math cmake-mode diff-hl systemd ido-vertical-mode ido-mode rust-mode yaml-mode wc-mode markdown-mode log4j-mode dockerfile-mode docker ddskk))
 '(safe-local-variable-values '((whitespace-line-column . 80)))
 '(tab-line-exclude-modes '(completion-list-mode compilation-mode))
 '(warning-suppress-types '((server))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "yellow2"))))
 '(hl-line ((t (:inherit nil :extend t :overline nil :underline "dark gray"))))
 '(tab-bar ((t (:inherit nil))))
 '(tab-bar-tab ((t (:inherit mode-line :box (:line-width (1 . 1) :style released-button)))))
 '(tab-bar-tab-inactive ((t (:inherit (mode-line-inactive tab-bar-mode)))))
 '(tab-line ((t (:inherit nil :background "grey85" :foreground "black" :height 1.0))))
 '(tab-line-tab-modified ((t (:inherit nil))))
 '(term-color-blue ((t (:background "dodgerblue" :foreground "dodgerblue")))))
;;;
(put 'upcase-region 'disabled nil)

(setq gc-cons-threshold gc-cons-threshold-default)

;(profiler-report) (profiler-stop)
