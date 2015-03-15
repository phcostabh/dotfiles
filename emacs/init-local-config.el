;;; Load color theme

(require-package 'ujelly-theme)

(load-theme 'ujelly t)

(require 'init-php-mode)

;;; Enter comand mode when typing ";"
(define-key evil-normal-state-map (kbd ";") 'evil-ex)

;;; Remove background color when in terminal.
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)

;;; Remember the cursor position of files when reopening them
(setq save-place-file "~/.cache/emacs/saveplace")
(setq-default save-place t)
(require 'saveplace)

;;; Select last yanked text
(evil-leader/set-key "V" 'exchange-point-and-mark)

(provide 'init-local-config)
;;;
