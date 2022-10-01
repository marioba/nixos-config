;; Load my org file with all the configurations

(package-initialize)

(defun load-config()
  "Load the actual configuration in literate 'org-mode' elisp."
  (interactive)
  (delete-file "~/.emacs.d/configuration.el")
  (org-babel-load-file "~/.emacs.d/configuration.org"))

(load-config)
;;(load-new-config)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
;;'(flycheck-flake8rc "~/.config/flake8")
 '(safe-local-variable-values
   '((eval add-hook 'after-save-hook
           (lambda nil
             (org-html-export-to-html t))
           t t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
