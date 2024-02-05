;;; elixir-spells.el --- Tools for Elixir -*- lexical-binding: t; -*-
;;
;;;
;; Author: Marcin Koziej <marcin@cahoots.pl>
;; Maintainer: Marcin Koziej <marcin@cahoots.pl>
;; Created: July 20, 2023
;; Modified: July 20, 2023
;; Version: 0.0.1
;; Keywords: Tools for Elixir development
;; Homepage: https://github.com/marcinkoziej/elixir-spells
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; Useful Elixir code
;;
;;; Code:

(require 'chatgpt-shell)
(require 'evil-commands)


(defun elixir-spells-document-function ()
  (interactive)

  (unless (use-region-p)
        ;; We are in a function body.
        (evil-forward-section-end)
        ;; set mark
        (push-mark)
        ;; go back to top
        (evil-backward-section-begin)
        (activate-mark)
        (message "Region active"))

  (chatgpt-shell-describe-code 0)
  (message "buf %s" (buffer-name))

  ;; XXX this seems to work
  (chatgpt-shell-mark-at-point-dwim)
  ;; XXX but no way to copy out the last answer from ChatGPT
  ;;
  (message "kill-ring-save %d %d" (region-beginning) (region-end))
  (kill-ring-save (region-beginning) (region-end))
  ;; (switch-to-buffer (other-buffer))
  ;; (insert "@doc \"\"\"")
  ;; (yank)
  ;; (insert "\"\"\"")
  )


(provide 'elixir-spells)

;;; elixir-spells.el ends here
