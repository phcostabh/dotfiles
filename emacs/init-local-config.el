;;; init-localconfig --- Load color theme
;;; Commentary:

;;; Code:

(require-package 'ujelly-theme)
(require-package 'git-gutter)
(require-package 'keyfreq)
(require-package 'multiple-cursors)
(require-package 'emmet-mode)

(load-theme 'ujelly t)

(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(global-git-gutter-mode +1)

;;; Remove background color when in terminal.
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;;; Remember the cursor position of files when reopening them
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "saveplace.el"))
(setq-default save-place t)

;;; Stop showing flycheck messages in a separate buffer.
(remove-hook 'before-save-hook #'add-flycheck-list-hook)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-,") 'mc/mark-all-like-this-dwim)
(global-set-key (kbd "C-;") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;;; Enter comand mode when typing ";"
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-normal-state-map (kbd "C-p") nil)
(define-key evil-insert-state-map (kbd "C-p") nil)
(define-key evil-normal-state-map (kbd "<SPC>f") 'file-fuzzy-finder)

;; Makes tab work as tab.
(define-key evil-insert-state-map (kbd "TAB") 'my-company-tab)


(require 'init-php-mode)

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

(provide 'init-local-config)
;;; init-local-config ends here
