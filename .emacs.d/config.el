;; ---------------------
    ;; -- Global Settings --
    ;; ---------------------
    ;; (add-to-list 'load-path "~/.emacs.d")
    (require 'cl)
    (require 'ido)
    (require 'ffap)
    (require 'uniquify)
    (require 'ansi-color)
    (require 'recentf)
    (require 'linum)
    ;;(require 'smooth-scrolling)
    (require 'whitespace)
    (require 'dired-x)
    (require 'compile)
    (ido-mode t)
    (normal-erase-is-backspace-mode 1)
    (put 'downcase-region 'disabled nil)
    (put 'upcase-region 'disabled nil)

    (global-set-key "\C-h" 'delete-backward-char)
    (global-set-key (kbd "C-x g") 'magit-status)
    (global-set-key (kbd "C-x '") #'imenu-list-smart-toggle) ;; for sidebuffer

    (tool-bar-mode -1)
    (menu-bar-mode -1)

    (setq make-backup-files nil)
    (setq auto-save-default nil)
    (setq inhibit-startup-screen t)
    (setq column-number-mode t)
    (setq save-abbrevs nil)
    (setq show-trailing-whitespace t)
    (setq suggest-key-bindings t)
    (setq vc-follow-symlinks t)

    (use-package ess
      :ensure t
      :defer t
      :init (require 'ess-site))

    (use-package web-mode
      :ensure t
      :mode
      (".dust$"
       ".html$"
       ".js$"
       ".css$"
       ".scss$"
      )
    )

  (setq-default indent-tabs-mode nil)

    ;; ---------------------------
    ;; -- Tide Mode --
    ;; ---------------------------
    (defun setup-tide-mode ()
      (interactive)
      (tide-setup)
      (flycheck-mode +1)
      (setq flycheck-check-syntax-automatically '(save mode-enabled))
      (eldoc-mode +1)
      (tide-hl-identifier-mode +1)
      ;; company is an optional dependency. You have to
      ;; install it separately via package-install
      ;; `M-x package-install [ret] company`
      (company-mode +1))

    ;; aligns annotation to the right hand side
    (setq company-tooltip-align-annotations t)

    ;; formats the buffer before saving
    (add-hook 'before-save-hook 'tide-format-before-save)

    (add-hook 'typescript-mode-hook #'setup-tide-mode)

    ;; format options
    (setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))


    ;; column numbering
    (setq column-number-mode t)

;; (use-package org
;;   :ensure t
;;   ;; ignore org-mode from upstream and use a manually installed version
;;   :pin manual)
    (define-key global-map "\C-cl" 'org-store-link)
    (define-key global-map "\C-ca" 'org-agenda)
    (global-set-key "\C-cc" 'org-capture)
    (global-set-key "\C-cb" 'org-iswitchb)
    (setq org-log-done t)

    (add-hook 'org-mode-hook
              (lambda () (imenu-add-to-menubar "Imenu")))

    ;; -----------------
    ;; -- EMACS Theme --
    ;; -----------------
    (require 'apropospriate)
    (load-theme 'apropospriate-dark t)


    ;; changing default tab spacing to 2 per tab instead of 8
    ;; tab-width is for tabs
    ;; use M-x untabify to remove tabs when necessary
    (setq tab-stop-list (number-sequence 2 120 2))
    (setq tab-width 2)


    ;; Web-mode colors
    (defun my-web-mode-hook ()
      "Hooks for Web mode."
      (setq web-mode-style-padding 2) ;; tags
      (setq web-mode-script-padding 2)
      (setq web-mode-markup-indent-offset 2) ;; tabs
      (setq web-mode-css-indent-offset 2)
      (setq web-mode-code-indent-offset 2)
      (set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "#98ff98")
  
      )

    (add-hook 'web-mode-hook  'my-web-mode-hook)


    ;; can't get auto-complete to work :(
    ;; (add-hook 'js2-mode-hook 'ac-js2-mode)
    ;; (add-hook 'js2-mode-hook 'skewer-mode)
    ;; (ac-config-default)


    ;; (setq ac-js2-evaluate-calls t)

    ;; 80 column ruler
    (setq-default header-line-format 
		  (list " " (make-string 79 ?-) "|"))

    ;; Nodejs repl mode
    (add-hook 'web-mode-hook
	      (lambda ()
		(define-key web-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
		(define-key web-mode-map (kbd "C-c C-n") 'nodejs-repl-send-line)
		(define-key web-mode-map (kbd "C-c C-c") 'nodejs-repl-send-region)
		(define-key web-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
		(define-key web-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))

    (add-hook 'js-mode-hook
	      (lambda ()
		(define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
		(define-key js-mode-map (kbd "C-c C-n") 'nodejs-repl-send-line)
		(define-key js-mode-map (kbd "C-c C-c") 'nodejs-repl-send-region)
		(define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
		(define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))

    (add-hook 'js2-mode-hook
	      (lambda ()
		(define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
		(define-key js2-mode-map (kbd "C-c C-n") 'nodejs-repl-send-line)
		(define-key js2-mode-map (kbd "C-c C-c") 'nodejs-repl-send-region)
		(define-key js2-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
		(define-key js2-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))
    (custom-set-variables
     ;; custom-set-variables was added by Custom.
     ;; If you edit it by hand, you could mess it up, so be careful.
     ;; Your init file should contain only one such instance.
     ;; If there is more than one, they won't work right.
     '(custom-safe-themes
       (quote
	("c3e6b52caa77cb09c049d3c973798bc64b5c43cc437d449eacf35b3e776bf85c" "5a0eee1070a4fc64268f008a4c7abfda32d912118e080e18c3c865ef864d1bea" default)))
     '(magit-diff-arguments (quote ("--no-ext-diff" "--stat")))
     '(magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256")))
     '(package-selected-packages
       (quote
	(lorem-ipsum ac-js2 skewer-mode yasnippet xbm-life tide php-mode nodejs-repl markdown-mode js2-mode indium go-mode auto-complete))))
    (custom-set-faces
     ;; custom-set-faces was added by Custom.
     ;; If you edit it by hand, you could mess it up, so be careful.
     ;; Your init file should contain only one such instance.
     ;; If there is more than one, they won't work right.
     )

    ;; (require 'multiple-cursors)
    ;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
    ;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
    ;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
    ;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


    (add-hook 'fountain-mode-hook 'olivetti-mode); enable olivetti in fountain always

(use-package which-key
  :ensure t
  :init
  (which-key-mode))