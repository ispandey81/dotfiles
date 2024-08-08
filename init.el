(setq inhibit-startup-message t) ;disables the startup page which is the default landing page of emacs
(setq visible-bell 1) ;disables the bell, uses flashing line instead
(visual-line-mode 1) ;add documentation here when I understand this
(recentf-mode 1) ;keep history of recently opened files and jump to them quickly using command - recentf
(setq history-length 10) ;number of prompts to save in the history for mini- buffer prompts for commands, navigate them with M-p and M-n
(savehist-mode 1) ;enable save history mode by default
(save-place-mode 1) ;remember and restore the last cursor position of opened files
(global-auto-revert-mode 1) ;keep the buffers in sync if the files change on disk
(setq global-auto-revert-non-file-buffers t) ;Revert dired and other buffers
;; (defun start-in-org-mode ()
;;   "Function to start Emacs in Org mode."
;;   (org-mode))

;; (add-hook 'emacs-startup-hook 'start-in-org-mode)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(menu-bar-mode -1)          ; Disable the menu bar
(set-fringe-mode 20)        ; Give some breathing room on the left and right
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;start emacs in fullscreen mode

(require 'package) ;require function is used to load libraries or packages

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			 ("melpa" . "https://melpa.org/packages/"))) ;set package repositories
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(setq use-package-always-ensure t)

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package magit)

(setq magit-refresh-status-buffer nil) ;copied from the magit manual

(setq magit-repository-directories '(("~/Documents/Repos" . 2))) ;set repositories location (number is the depth to search for git repos in the specified folder), can also have multiple locations defined

(setq magit-repolist-columns '(("Name" 25 magit-repolist-column-ident nil)
 ("Version" 25 magit-repolist-column-version
  ((:sort magit-repolist-version<)))
 ("Unpulled" 8 magit-repolist-column-unpulled-from-upstream
  ((:right-align t)
   (:sort <)))
 ("Unpushed" 8 magit-repolist-column-unpushed-to-upstream
  ((:right-align t)
   (:sort <)))
 ("Branch" 25 magit-repolist-column-branch nil)
 ("Path" 99 magit-repolist-column-path nil))) ;added the branch column to display the current branch of the repo

(use-package elfeed)

(use-package projectile)
(use-package flycheck)
(use-package yasnippet :config (yas-global-mode))
(use-package lsp-mode :hook ((lsp-mode . lsp-enable-which-key-integration)))
(use-package hydra)
(use-package company)
(use-package lsp-ui)
(use-package lsp-java :config (add-hook 'java-mode-hook 'lsp))
(use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
(use-package dap-java :ensure nil)
(use-package lsp-ivy)
(use-package lsp-treemacs)

(use-package centaur-tabs
  :demand
  :hook
  (dired-mode . centaur-tabs-local-mode)
  (vterm-mode . centaur-tabs-local-mode)
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-set-bar 'under)
  (setq x-underline-at-descent-line t)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-modified-marker "*"))
(centaur-tabs-headline-match)
(centaur-tabs-change-fonts "Iosevka" 200)

(setq auto-revert-buffer-list-filter
      'magit-auto-revert-repository-buffer-p) ;copied from the magit manual

(use-package org
  :custom
  (org-log-done 'time))  ;set timestamp to the task when it is marked as done
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(setq org-startup-folded t) ;start org files in a folded state

(require 'ox-md)  ;enable markdown format export from an org mode file

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1)
  ;; location of which-key window. valid values: top, bottom, left, right,
  ;; or a list of any of the two. If it's a list, which-key will always try
  ;; the first location first. It will go to the second location if theRe is
  ;; not enough room to display any keys in the first location
  (setq which-key-side-window-location '(right bottom)))

(set-face-attribute 'default nil :font "Iosevka" :height 200) ;installed fonts on my operating system using ttf files downloaded from the internet, once the fonts are available this function sets the font for emacs

;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes") ;downloaded the dracula theme.el file from the internet, created themes directory in .emacs.d directory and pasted the theme.el file in there
;(load-theme 'dracula t) ;loads theme which could be builtin or from a package

(load-theme 'modus-operandi) ;built-in light theme, there is also a dark theme called modus-vivendi

(use-package all-the-icons
  :if (display-graphic-p))

(global-set-key (kbd "M-o") 'ace-window) ;ace window for moving between windows

(use-package golden-ratio
  :config
  (golden-ratio-mode 1))

;; use-package with package.el:
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-icon-type 'all-the-icons))

(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package auto-package-update
  :custom
  (auto-package-update-interval 1)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  (auto-package-update-delete-old-versions t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "08:00"))

(use-package helpful)
;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(global-set-key (kbd "C-h f") #'helpful-callable)

(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)

(column-number-mode)  ;display column numbers in modeline
(global-display-line-numbers-mode t)  ;display line numbers in modeline

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		shell-mode-hook
		vterm-mode-hook
		treemacs-mode-hook))                
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;Move customization variable to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage) ;do not generate any messages for this custom file
