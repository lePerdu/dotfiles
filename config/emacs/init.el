;; TODO Use `custom-set-variables' instead of mixing `setq' and mode functions

;; TODO Is there a better way to disable `customize-save-customized'?
(custom-set-variables '(custom-file "/dev/null"))

;;; Use UTF-8

(set-default-coding-systems 'utf-8-unix)
(custom-set-variables
 '(current-language-environment "UTF-8"))

;;; Auto-save and backups

(custom-set-variables
 '(auto-save-default nil)
 '(auto-save-visited-interval 30)
 '(auto-save-visited-mode t)
 '(backup-directory-alist '(("." . "~/.config/emacs/backup")))
 '(create-lockfiles nil))

;;; Misc editing functionality

(custom-set-variables
 '(delete-selection-mode t)
 '(cursor-type 'bar)
 '(column-number-mode t)
 '(display-line-numbers-type 'relative)
 '(electric-pair-mode t)
 '(indent-tabs-mode nil)
 '(require-final-newline t)
 '(tab-width 4)
 '(tab-always-indent t)
 '(set-mark-command-repeat-pop t)
 '(use-short-answers t)
 '(next-error-highlight t)
 '(next-error-highlight-no-select t)
 '(parse-sexp-ignore-comments t)
 '(search-whitespace-regexp "[-_ \\t\\r\\n]+"))

;;; Frame config
(custom-set-variables
 ;; '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil))
(modify-all-frames-parameters '((fullscreen . fullboth)))

;;; Mini-buffer

;; TODO This is probably only necessary in certain mode
;; (setq compilation-error-screen-columns nil)
(custom-set-variables
 '(completion-styles '(partial-completion flex))
 '(fido-vertical-mode t)
 '(minibuffer-electric-default-mode t))

(custom-set-variables
 '(dired-listing-switches "-alh"))

;; TODO Figure out how to better synchronize PATH between EMACS and system shell
;; - Use shell in login process so that EMACS is a subprocess of it?
;; - Run shell in EMACS startup and extract variables?
;; - Duplicate config for NVM, ghcup, rustup, opam, etc.?
(add-to-list 'exec-path (expand-file-name "~/.local/bin"))
;; (setenv "GHCUP_INSTALL_BASE_PREFIX" (expand-file-name "~"))
;; (add-to-list 'exec-path (expand-file-name "~/.cargo"))
;; (add-to-list 'exec-path (expand-file-name "~/.ghcup/bin"))
;; (add-to-list 'exec-path (expand-file-name "~/.cabal/bin"))

(defun my-set-prog-mode-vars ()
  "Establish settings specific to programming modes."
  (interactive)
  (setq show-trailing-whitespace t))

(add-hook 'prog-mode-hook #'my-set-prog-mode-vars)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'flyspell-prog-mode)

(add-hook 'text-mode-hook #'turn-on-flyspell)
(add-hook 'text-mode-hook #'turn-on-auto-fill)

;; Tree-sitter grammar sources
(setq treesit-language-source-alist
      '((javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (c "https://github.com/tree-sitter/tree-sitter-c")
        (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
        (rust "https://github.com/tree-sitter/tree-sitter-rust")
        ;; (html "https://github.com/tree-sitter/tree-sitter-html")
        ;; There isn't a markdown-ts-mode, so not sure if this is used by markdown-mode
        ;; (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (bash "https://github.com/tree-sitter/tree-sitter-bash")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; Run this to (re)install all grammars
;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))

(dolist (mode-pair
         '((js-mode . js-ts-mode)
           ;; Alias for js-mode. The alias needs to be re-mapped
           ;; separately
           (javascript-mode . js-ts-mode)
           ;; Is this needed? js-mode switches to js-jsx-mode as I
           ;; understand. If that's the case, then overriding js-mode
           ;; should be sufficient. There is no typescript-mode to
           ;; remap as there is only typescript-ts-mode.
           (js-jsx-mode . js-ts-mode)
           (python-mode . python-ts-mode)
           (c-mode . c-ts-mode)
           (c++-mode . c++-ts-mode)
           (c-or-c++-mode . c-or-c++-ts-mode)
           ;; (html-mode . html-ts-mode)
           (js-json-mode . json-ts-mode)
           (sh-mode . bash-ts-mode)))
  (add-to-list 'major-mode-remap-alist mode-pair))

(require 'use-package)
(custom-set-variables
 '(use-package-always-ensure t))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(use-package dracula-theme)

;; D-Bus listener to change light/dark theme based on system settings
;; TODO Use `:custom' for settings
;; TODO Implement as global minor mode
;; TODO Implement with autoloading?
(use-package auto-color-scheme
  :load-path "~/.config/emacs/lisp"
  :config
  (setq auto-color-scheme-dark-theme 'dracula)
  (setq auto-color-scheme-use-old-dbus-read-method t)
  (auto-color-scheme-activate))

(use-package company
  :hook
  ((prog-mode text-mode eshell-mode comint-mode) . company-mode)
  :bind
  (:map company-mode-map
        ("TAB" . company-indent-or-complete-common)))

(use-package iedit)

(use-package flymake
  :bind (:map flymake-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-prev-error)))

(use-package flycheck
  :custom
  (flycheck-global-modes '(tuareg-mode emacs-lisp-mode))
  (global-flycheck-mode t "Enable Flycheck globally.")
  :bind (:map flycheck-mode-map
              ("M-n" . flycheck-next-error)
              ("M-p" . flycheck-previous-error)))

(use-package flyspell
  :bind
  (:map flyspell-mode-map
		;; `iedit' mode uses the same keybinding
		;; TODO Find an alternative binding for `flyspell-auto-correct-previous-word'?
		("C-;" . nil)))

(use-package typescript-ts-mode)
(use-package yaml-ts-mode
  :config
  (add-hook 'yaml-ts-mode-hook (lambda () (run-hooks 'prog-mode-hook))))
;; (use-package toml-ts-mode)

(use-package opam-switch-mode
  :config (opam-switch-set-switch "default")
  :hook (tuareg-mode . opam-switch-mode))

(use-package tuareg)

(use-package merlin
  :ensure nil
  :load-path opam-site-lisp
  :hook (tuareg-mode . merlin-mode))

(use-package merlin-company
  :ensure nil
  :load-path opam-site-lisp)

(use-package merlin-iedit
  :ensure nil
  :load-path opam-site-lisp)

(use-package flycheck-ocaml
  :config (setq merlin-error-after-save nil)
  :hook (merlin-mode . flycheck-ocaml-setup))

(use-package ocamlformat
  :ensure nil
  :load-path opam-site-lisp
  :custom (ocamlformat-show-errors nil "Don't show errors from formatter.")
  :hook (before-save . ocamlformat-before-save))

(use-package dune
  :ensure nil
  :load-path opam-site-lisp)
(use-package dune-flymake
  :ensure nil
  :load-path opam-site-lisp)
;; ;; (use-package dune-watch
;;   :load-path opam-site-lisp)

(use-package utop
  :ensure nil
  :load-path opam-site-lisp
  :custom (utop-command "dune utop . -- -emacs" "Use dune utop by default")
  :hook (tuareg-mode . utop-minor-mode)
  :bind (:map utop-minor-mode-map
              ("C-M-x" . utop-eval-phrase)))

;; ANSI color in compilation buffer
;; (require 'ansi-color)
;; (defun colorize-compilation-buffer ()
;;   (toggle-read-only)
;;   (ansi-color-apply-on-region (point-min) (point-max))
;;   (toggle-read-only))
;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(use-package markdown-mode)

(use-package nvm
  :config
  (nvm-use "18"))

;; TODO Use autoloading?
(use-package whisp
  :load-path "~/.config/emacs/lisp")

(use-package editorconfig
  :config
  (add-to-list 'editorconfig-exclude-modes 'emacs-lisp-mode)
  (editorconfig-mode))

(use-package which-key
  :config (which-key-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package magit
  :config (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

(defun eglot-format-on-save ()
  "Setup EMACS to use eglot-format-buffer before saving."
  (interactive)
  (if (eglot-managed-p)
      (add-hook 'before-save-hook #'eglot-format-buffer nil t)
    (remove-hook 'before-save-hook #'eglot-format-buffer t)))

(use-package eglot
  :custom
  (eglot-confirm-server-initiated-edits nil "Don't require confirmation for edits.")
  :config
  (add-hook 'eglot-managed-mode-hook 'eglot-format-on-save)
  :hook
  ((js-base-mode
    typescript-ts-base-mode
    c-mode-common
    c-ts-base-mode)
   . eglot-ensure)
  :bind
  (:map eglot-mode-map
        ("C-c a" . eglot-code-actions)))

;; Use mouse buttons for forward/back (works in info, help, etc.)
(keymap-global-set "<mouse-8>" "<XF86Back>")
(keymap-global-set "<mouse-9>" "<XF86Forward>")

(keymap-global-set "C-c f" #'find-file-at-point)

(defun my-edit-init-file ()
  "Edit init file."
  (interactive)
  (find-file user-init-file))

(defun my-edit-init-file-other-window ()
  "Edit init file in other window."
  (interactive)
  (other-window 1)
  (my-edit-init-file))

(keymap-global-set "C-c i" #'my-edit-init-file)
(keymap-set ctl-x-4-map "i" #'my-edit-init-file-other-window)

(defun kill-this-buffer-always ()
  "Kill the current buffer.

This is like `kill-this-buffer', but works when called interactively.

`kill-this-buffer' only works when called from the menu bar."
  (interactive)
  (cond
   ((minibufferp)
    (abort-recursive-edit))
   (t
    (kill-buffer (current-buffer)))))

(keymap-global-set "C-x k" #'kill-this-buffer-always)
(keymap-global-set "C-c p" #'delete-pair)
(keymap-global-set "C-c DEL" #'switch-to-prev-buffer)
(keymap-global-set "M-o" #'other-window)
(keymap-global-set "<f1>" #'magit-status)
(keymap-global-set "<f2>" #'eshell)
