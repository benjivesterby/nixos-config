;; bootstrap straight start
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(use-package straight
  :custom
  (straight-use-package-by-default t))
;; bootstrap straight end

(use-package evil
  :ensure t 
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t 
  :config
  (evil-collection-init))

(use-package doom-themes
  :ensure t )
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
(load-theme 'doom-one t)

(defun my/setup-font-faces ()
(when (display-graphic-p)
  (set-face-attribute 'default nil
                     :font "Inconsolata LGC Nerd Font 11"
                     :weight 'medium)
  )
)

(defun my/on-init ()
	(my/setup-font-faces)
)

(add-hook 'after-init-hook 'my/on-init)
(add-hook 'server-after-make-frame-hook 'my/on-init)

(setq default-line-spacing 0.10)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq warning-minimum-level :error)
(setq inhibit-startup-screen t)

;; Disable toolbar, menubar and scrollbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package doom-modeline
  :ensure t 
  :init (doom-modeline-mode 1))

;; One line scrolling
(setq scroll-step 1)
(setq scroll-conservatively 10000)

(global-display-line-numbers-mode)

(global-visual-line-mode t)
      
(use-package dashboard
  :ensure t 
  :init
  (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
  (setq dashboard-center-content nil)
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
			(projects . 5)))
  (setq dashboard-set-navigator t)
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-footer-messages '("I showed you my source code, plz respond."))

(use-package direnv
  :ensure t 
  :config
  (direnv-mode))

(use-package helm
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(use-package company
  :ensure t
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.0))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("dist" "*.el"))
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'copilot-mode)
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion))

(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-file-watch-threshold 4000))

(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-doc-show-with-cursor nil))

(use-package rustic
  :ensure t
  :config
  (setq rustic-format-on-save t))

(use-package go-mode
  :ensure t
  :init
  (add-hook 'go-mode-hook 'lsp-deferred))

(use-package dired-sidebar
  :ensure t)

(eval-after-load 'dired
  '(evil-define-key 'normal dired-mode-map [mouse-2] 'dired-mouse-find-file)
)