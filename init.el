(setq inhibit-startup-message t) ;disables the startup page which is the default landing page of emacs
(setq visible-bell 1) ;disables the bell, uses flashing line instead
(visual-line-mode 1) ;add documentation here when I understand this
(recentf-mode 1) ;keep history of recently opened files and jump to them quickly using command - recentf
(setq history-length 10) ;number of prompts to save in the history for mini- buffer prompts for commands, navigate them with M-p and M-n
(savehist-mode 1) ;enable save history mode by default
(save-place-mode 1) ;remember and restore the last cursor position of opened files
(global-auto-revert-mode 1) ;keep the buffers in sync if the files change on disk
(tab-bar-mode 1) ;enable the builtin tab bar mode
(setq global-auto-revert-non-file-buffers t) ;Revert dired and other buffers
;; (defun start-in-org-mode ()
;;   "Function to start Emacs in Org mode."
;;   (org-mode))

;; (add-hook 'emacs-startup-hook 'start-in-org-mode)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
;(menu-bar-mode -1)          ; Disable the menu bar
(set-fringe-mode 20)        ; Give some breathing room on the left and right
(add-to-list 'default-frame-alist '(fullscreen . maximized));start emacs in fullscreen mode
;; (setq initial-frame-alist '((top . 0) (left . 0) (width . 80) (height . 20))) ;
;; width and height when emacs open for the first time

(fset 'yes-or-no-p 'y-or-n-p)

(require 'package) ;require function is used to load libraries or packages

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			 ("melpa" . "https://melpa.org/packages/"))) ;set package repositories
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package) ;mandatory even though use-package is built in something to do with lazy loading i think

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

(use-package gptel)
;; OPTIONAL configuration
(setq
 gptel-model 'llama3.2
 gptel-backend (gptel-make-ollama "Ollama"
                 :host "localhost:11434"
                 :stream t
                 :models '(llama3.2)))
;; (setq gptel-api-key )

(use-package clojure-mode)
(setq clojure-indent-style 'always-indent
      clojure-indent-keyword-style 'always-indent
      clojure-enable-indent-specs nil)
(use-package cider
  :ensure t)

(use-package elfeed)

;; (use-package pdf-tools)

;; (use-package projectile)
;; (use-package flycheck)
;; (use-package yasnippet :config (yas-global-mode))
;; (use-package lsp-mode :hook ((lsp-mode . lsp-enable-which-key-integration)))
;; (use-package hydra)
;; (use-package company)
;; (use-package lsp-ui)
;; (use-package lsp-java :config (add-hook 'java-mode-hook 'lsp))
;; (use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
;; (use-package dap-java :ensure nil)
;; (use-package lsp-ivy)
;; (use-package lsp-treemacs)
;; (use-package lsp-pyright
;;   :hook (python-mode . (lambda ()
;;                           (require 'lsp-pyright)
;;                           (lsp))))  ; or lsp-deferred

(use-package vterm
    :ensure t)

;; (use-package centaur-tabs
;;   :demand
;;   :hook
;;   (dired-mode . centaur-tabs-local-mode)
;;   (vterm-mode . centaur-tabs-local-mode)
;;   :config
;;   (centaur-tabs-mode t)
;;   (setq centaur-tabs-set-bar 'under)
;;   (setq x-underline-at-descent-line t)
;;   (setq centaur-tabs-set-modified-marker t)
;;   (setq centaur-tabs-modified-marker "*"))
;; (centaur-tabs-headline-match)
;; (centaur-tabs-change-fonts "Iosevka" 200)

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
;; (use-package dashboard
;;   :config
;;   (dashboard-setup-startup-hook)
;;   (setq dashboard-icon-type 'all-the-icons))

;; (use-package ivy
;;   :diminish
;;   :config
;;   (ivy-mode 1))

;; The `vertico' package applies a vertical layout to the minibuffer.
;; It also pops up the minibuffer eagerly so we can see the available
;; options without further interactions.  This package is very fast
;; and "just works", though it also is highly customisable in case we
;; need to modify its behaviour.
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:cff33514-d3ac-4c16-a889-ea39d7346dc5
(use-package vertico
  :ensure t
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (vertico-mode 1))

(setq read-buffer-completion-ignore-case t
      completion-ignore-case t)

;; The `marginalia' package provides helpful annotations next to
;; completion candidates in the minibuffer.  The information on
;; display depends on the type of content.  If it is about files, it
;; shows file permissions and the last modified date.  If it is a
;; buffer, it shows the buffer's size, major mode, and the like.
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:bd3f7a1d-a53d-4d3e-860e-25c5b35d8e7e
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

;; The `orderless' package lets the minibuffer use an out-of-order
;; pattern matching algorithm.  It matches space-separated words or
;; regular expressions in any order.  In its simplest form, something
;; like "ins pac" matches `package-menu-mark-install' as well as
;; `package-install'.  This is a powerful tool because we no longer
;; need to remember exactly how something is named.
;;
;; Note that Emacs has lots of "completion styles" (pattern matching
;; algorithms), but let us keep things simple.
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:7cc77fd0-8f98-4fc0-80be-48a758fcb6e2
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

;; The `consult' package provides lots of commands that are enhanced
;; variants of basic, built-in functionality.  One of the headline
;; features of `consult' is its preview facility, where it shows in
;; another Emacs window the context of what is currently matched in
;; the minibuffer.  Here I define key bindings for some commands you
;; may find useful.  The mnemonic for their prefix is "alternative
;; search" (as opposed to the basic C-s or C-r keys).
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:22e97b4c-d88d-4deb-9ab3-f80631f9ff1d
(use-package consult
  :ensure t
  :bind (;; A recursive grep
         ("M-s M-g" . consult-grep)
         ;; Search for files names recursively
         ("M-s M-f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search the current buffer
         ("M-s M-l" . consult-line)
         ;; Switch to another buffer, or bookmarked file, or recently
         ;; opened file.
         ("M-s M-b" . consult-buffer)))

;; The `embark' package lets you target the thing or context at point
;; and select an action to perform on it.  Use the `embark-act'
;; command while over something to find relevant commands.
;;
;; When inside the minibuffer, `embark' can collect/export the
;; contents to a fully fledged Emacs buffer.  The `embark-collect'
;; command retains the original behaviour of the minibuffer, meaning
;; that if you navigate over the candidate at hit RET, it will do what
;; the minibuffer would have done.  In contrast, the `embark-export'
;; command reads the metadata to figure out what category this is and
;; places them in a buffer whose major mode is specialised for that
;; type of content.  For example, when we are completing against
;; files, the export will take us to a `dired-mode' buffer; when we
;; preview the results of a grep, the export will put us in a
;; `grep-mode' buffer.
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:61863da4-8739-42ae-a30f-6e9d686e1995
(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)))

;; The `embark-consult' package is glue code to tie together `embark'
;; and `consult'.
(use-package embark-consult
  :ensure t)

;; The `wgrep' packages lets us edit the results of a grep search
;; while inside a `grep-mode' buffer.  All we need is to toggle the
;; editable mode, make the changes, and then type C-c C-c to confirm
;; or C-c C-k to abort.
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:9a3581df-ab18-4266-815e-2edd7f7e4852
(use-package wgrep
  :ensure t
  :bind ( :map grep-mode-map
          ("e" . wgrep-change-to-wgrep-mode)
          ("C-x C-q" . wgrep-change-to-wgrep-mode)
          ("C-c C-c" . wgrep-finish-edit)))

;; The built-in `savehist-mode' saves minibuffer histories.  Vertico
;; can then use that information to put recently selected options at
;; the top.
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:25765797-27a5-431e-8aa4-cc890a6a913a
(savehist-mode 1)

;; The built-in `recentf-mode' keeps track of recently visited files.
;; You can then access those through the `consult-buffer' interface or
;; with `recentf-open'/`recentf-open-files'.
;;
;; I do not use this facility, because the files I care about are
;; either in projects or are bookmarked.
(recentf-mode 1)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 1)
  ;; (auto-package-update-prompt-before-update t)
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

;; Temporarily increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Restore to normal value after startup (e.g. 50MB)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 50 1024 1024))))

;(setq scroll-margin 15)

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
