(setq ring-bell-function 'ignore)
;; Unbind Pesky Sleep Button
(global-unset-key [(control z)])
(global-unset-key [(control x)(control z)])

(setq display-time-24hr-format t)
(setq display-time-format "%H:%M - %d %B %Y")
(display-time-mode t)

(show-paren-mode 1)

(use-package magit
  :ensure t
:bind (("C-x g" . magit-status)))
;; (global-set-key (kbd "C-x g") 'magit-status)

;; ---------------------------
    ;; -- Tide Mode --
    ;; ---------------------------
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

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

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)
(use-package ido-vertical-mode
:ensure t
:init
(ido-vertical-mode t))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; ---------------------
    ;; -- Global Settings --
    ;; ---------------------
    ;; (add-to-list 'load-path "~/.emacs.d")
    (require 'cl)
    (require 'ffap)
    (require 'uniquify)
    (require 'ansi-color)
    (require 'recentf)
    (require 'linum)
    ;;(require 'smooth-scrolling)
    (require 'whitespace)
    (require 'dired-x)
    (require 'compile)
    (normal-erase-is-backspace-mode 1)
    (put 'downcase-region 'disabled nil)
    (put 'upcase-region 'disabled nil)
    (global-set-key "\C-h" 'delete-backward-char)
    (global-set-key (kbd "C-x '") #'imenu-list-smart-toggle) ;; for sidebuffer
    (use-package imenu-list
      :ensure t
;;      :bind (("C-'" . imenu-list-smart-toggle))
      :config
      (setq imenu-list-focus-after-activation t
        imenu-list-auto-resize nil))

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

    (use-package julia-mode
      :ensure t
      :defer t
      )

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
       ".jsx$"
       ".css$"
       ".scss$"
       )
      )

    (setq-default indent-tabs-mode nil)

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
    (use-package apropospriate-theme
      :ensure t
      :config 
      (load-theme 'apropospriate-dark t))



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

    
    (use-package fountain-mode
      :ensure t)
    (use-package olivetti
      :ensure t)

    (add-hook 'fountain-mode-hook 'olivetti-mode); enable olivetti in fountain always

    (use-package ox-reveal
     :ensure t)
    ;; must set local reveal root in each reveal file.
     
    (use-package "htmlize"
     :ensure t)

    (use-package org-bullets
      :ensure t
      :config
      (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x" . smex))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(defun kill-whole-word ()
  "Kills the entire word your cursor is in. Equivalent to 'ciw' in vim."
  (interactive)
  (forward-char 1)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w k") 'daedreth/kill-whole-word)

(defun config-reload ()
  "Reloads ~/.emacs.d/config.org at runtime"
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(defun kill-current-buffer ()
  "Kills the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(use-package rainbow-mode
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "SPC") #'company-abort))

(use-package projectile
  :ensure t
  :init
    (projectile-mode 1))
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(use-package dashboard
    :ensure t
    :config
      (dashboard-setup-startup-hook)
      (setq dashboard-startup-banner 'official)
      (setq dashboard-items '((recents  . 5)
                              (projects . 5)
                              (agenda . 5))) ;; requires projectile mode
      (setq dashboard-banner-logo-title "Greetings"))

(use-package spaceline
:ensure t
:config
(require 'spaceline-config)
(setq spaceline-buffer-encoding-abbrev-p nil)
;;(setq spaceline-line-column-p nil)
;;(setq spaceline-line-p nil)
(setq powerline-default-separator (quote arrow))
(spaceline-spacemacs-theme))

(setq powerline-default-separator nil)

(use-package multiple-cursors
  :ensure t
  :bind ("C-c q" . 'mark-next-like-this))

(use-package expand-region
  :ensure t
  :bind ("C-q" . er/expand-region))

(use-package emmet-mode
  :ensure t
  :init (add-hook 'web-mode-hook #'emmet-mode)
)

(defun my-emmet-mode-hook ()
      "Hooks for emmet mode. so that jsx works with web mode"
      (when (string= (file-name-extension buffer-file-name) "jsx")
      (setq-local emmet-expand-jsx-className? t)
      )
)
(add-hook 'emmet-mode-hook  'my-emmet-mode-hook)

(use-package restclient
  :ensure t)

(use-package poly-R
  :ensure t)
(use-package polymode
    :mode
    (("\\.Rmd" . poly-markdown+r-mode))
    :init
    (autoload 'r-mode "ess-site.el" "Major mode for editing R source." t)
    :defer t
    )

(defun func-region (start end func)
  "run a function over the region between START and END in current buffer."
  (save-excursion
    (let ((text (delete-and-extract-region start end)))
      (insert (funcall func text)))))
(defun hex-region (start end)
  "urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-hexify-string))
(defun unhex-region (start end)
  "de-urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-unhex-string))

(use-package csv-mode
  :mode ("\\.csv$" . csv-mode)
  :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-follow-delay             0.2
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-desc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(global-set-key (kbd "C-x d") 'treemacs)
(global-set-key (kbd "C-x C-d") 'treemacs)

(use-package flyspell
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (flyspell-mode))))
