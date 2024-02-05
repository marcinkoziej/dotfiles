;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marcin Koziej"
      user-mail-address "marcin@cahoots.pl")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)


;;; TODO other fonts to check (te fonty nie mają jakiegoś symbolu który używa doom modeline)
(setq doom-font (font-spec :family "Iosevka NFM" :size 13 ))

;;       doom-big-font (font-spec :family "Iosevka NFM" :size 16 )
;;       doom-symbol-font (font-spec :family "Iosevka NFP" :size 16 ))
;;; doom-serif-font (font-spec :family "Libre Baskerville" :size 22 )
;;; doom-variable-pitch-font (font-spec :family "Concourse T4 Tab" :size 27))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(map! :map evil-window-map
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right
      )

(load! "commands.el")

(map! :leader
      :desc "Switch to last buffer"
      [tab] #'switch-to-other-buffer)

(map! :leader "c /" #'comment-or-uncomment-region)

;; IDE
(setq typescript-indent-level 2)

;; Tree  Sitter
;; (define-derived-mode heex-mode html-mode "HEEx"
;;                      "Major mode for editing HEEx files")
;; (add-to-list 'auto-mode-alist '("\\.heex?\\'" . heex-ts-mode))
;;
;; TODO unofficial script to build grammars is:
;; https://github.com/casouri/tree-sitter-module

(use-package! treesit
  :config
  (setq treesit-extra-load-path '("/home/marcin/.tree-sitter/bin"))
  )



;;   :config
;;   ;; tip from:
;;   ;; https://blog.evalcode.com/elixir-heex-highlighting-in-emacs/
;;   ;; Load custom heex
;;   ;; 1. git clone https://github.com/phoenixframework/tree-sitter-heex.git
;;   (tree-sitter-load 'heex)
;;   (add-to-list 'tree-sitter-major-mode-language-alist '(heex-mode . heex))
;;   )

;; (setq js2-basic-offset 2)
(setq js-indent-level 2)

(use-package eglot
  :config
  (require 'org-compat)
  (setenv "ASDF_DIR" "/opt/asdf-vm") ;; because elixir ls looks for asdf under ~/.asdf
  (add-to-list 'exec-path "~/.local/share/elixir-ls")
  (add-to-list 'eglot-server-programs '(elixir-mode "~/.local/share/elixir-ls/release/language_server.sh"))
  )



;; XXX jakbym chciał używać jednak lsp-mode to 1. wycommentuj to use-package eglot 2. w init.el usun (lsp +eglot)
;; 3. odcommentuj to poniżej
;; ELIXIR
;; (use-package lsp-mode
;;   :commands lsp
;;   :ensure t
;;   :diminish lsp-mode
;;   :hook (elixir-mode . lsp)
;;   :init
;;   (add-to-list 'exec-path "~/.local/share/elixir-ls"))

;; XXX spell-fu does not support polish ?
(use-package spell-fu

  :hook
  (spell-fu-mode . (lambda ()
                     (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "en"))
                     (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "pl")))
                     ))


;; Tell `rescript-mode` how to run your copy of `server.js` from rescript-vscode
;; (you'll have to adjust the path here to match your local system):
(customize-set-variable
  'lsp-rescript-server-command
    '("node" "/home/marcin/Projects/rescript-vscode/server/out/server.js" "--stdio"))

(with-eval-after-load 'rescript-mode
  ;; Tell `lsp-mode` about the `rescript-vscode` LSP server
  (require 'lsp-rescript)
  ;; Enable `lsp-mode` in rescript-mode buffers
  (add-hook 'rescript-mode-hook 'lsp-deferred)
  ;; Enable display of type information in rescript-mode buffers
  (require 'lsp-ui)
  (add-hook 'rescript-mode-hook 'lsp-ui-doc-mode))


(load! "lisp/fancy-org.el")

;; MJML
 (add-to-list 'auto-mode-alist '("\\.mjml$" . html-mode))

; Nag to start org clock
;; This does not work well - the notifications are an annoyance and not visible at all
;; (org-nag-clock-mode 1)


;; Remove the evil collection bindings for org-roam because they break RET
(use-package! evil
  :config
  (setq +evil-collection-disabled-list (add-to-list '+evil-collection-disabled-list 'org-roam)))


(after! projectile
;; How to detect project root
  (setq projectile-project-root-functions
        '(projectile-root-local
          projectile-root-marked
          projectile-root-top-down
          projectile-root-top-down-recurring
          projectile-root-bottom-up))
)

(use-package! org-pomodoro
  :config
  (setq org-pomodoro-audio-player "pacat --volume=30000 --file-format")
  )

(map! :map org-mode-map
      "C-c C-x C-i" #'org-pomodoro
      "C-c C-x C-u" #'org-clock-in
      )

; TODO find out how to pass full path or use some load-path magic
;(after! chatgpt-shell
;  (require 'dall-e-shell))

;; ChatGPT integrations
(if (getenv "OPENAI_API_KEY")
    (progn
      (use-package! chatgpt-shell
        :ensure t
        :custom
        (
         (chatgpt-shell-model-version "gpt-4")
         (chatgpt-shell-openai-key (getenv "OPENAI_API_KEY"))))


      (use-package! gptel
        :config
        (setq! gptel-api-key (getenv "OPENAI_API_KEY"))
        (setq! gptel-model "gpt-4o") ;; na bogato
        (global-set-key (kbd "C-c RET") 'gptel-send))

      (use-package! dall-e-shell
        :load-path "/home/marcin/.emacs.d/.local/straight/repos/chatgpt-shell"
        :ensure t
        :custom
        ((dall-e-shell-openai-key (getenv "OPENAI_API_KEY"))
         (dall-e-shell-model-version "dall-e-3"))
        )
      ))

;   (lambda ()
 ;     (auth-source-pass-get 'secret )))))

;(use-package! gleam-mode
;  :load-path "/home/marcin/Projects/external/gleam-mode"
;  )


(use-package! elixir-ts-mode
              :load-path "/home/marcin/Projects/external/elixir-ts-mode")

;;(after! flycheck
;;  (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
;;
(add-load-path! "lisp")


(use-package! yaml-mode
  :init
  (use-package! yaml-path)
  (map! :leader
        :prefix "c"
        :desc "Display where in Yaml file are you"
        "-" 'yaml-path/path
        )
  )

(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (gleam "https://github.com/gleam-lang/gleam-mode")
     (elixir "https://github.com/elixir-lang/tree-sitter-elixir")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; install all
;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
