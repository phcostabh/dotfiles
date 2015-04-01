;;; Load color theme

(require-package 'ujelly-theme)

(load-theme 'ujelly t)

;;; Enter comand mode when typing ";"
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-normal-state-map (kbd "C-p") nil)
(define-key evil-insert-state-map (kbd "C-p") nil)
(define-key evil-normal-state-map (kbd "<SPC>f") 'file-fuzzy-finder)

;;; Remove background color when in terminal.
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)

;;; Remember the cursor position of files when reopening them
(setq save-place-file "~/.cache/emacs/saveplace")
(setq-default save-place t)

;;; Stop showing flycheck messages in a separate buffer.
(remove-hook 'before-save-hook #'add-flycheck-list-hook)

; (require-package 'multiple-cursors)
; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
; (global-set-key (kbd "C-,") 'mc/mark-all-like-this-dwim)
; (global-set-key (kbd "C-;") 'mc/mark-more-like-this-extended)
; (global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

(require 'saveplace)
(require 'init-php-mode)

(provide 'init-local-config)
;;;
