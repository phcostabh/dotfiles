(require-package 'php-mode)
(require 'php-mode)

(defun php-cs-fixer ()
  (interactive)
  (setq filename (buffer-file-name (current-buffer)))
  (call-process "php-cs-fixer" nil nil nil "fix" filename )
  (revert-buffer t t)
  )

(add-hook 'php-mode-hook (lambda ()
    (add-hook 'after-save-hook 'php-cs-fixer t t)))

(provide 'init-php-mode)
