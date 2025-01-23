(require 'package)
(setq package-enable-at-startup nil)
;; (setq debug-on-error t)		
;; adds melpa packages to package-list
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)	     

;; makes it easy to install other packages 
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(use-package org
    :load-path "~/.emacs.d/elpa/org-mode/lisp/")
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))


;; display startup time



;; (defun efs/display-startup-time ()
;;   (message "Emacs loaded in %s with %d garbage collections."
;;            (format "%.2f seconds"
;;                    (float-time
;;                    (time-subtract after-init-time before-init-time)))
;;            gcs-done))

;; (add-hook 'emacs-startup-hook #'efs/display-startup-time)
(put 'narrow-to-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ox-hugo python-pytest pyvenv direnv python-mode org-habit-stats gptel org-mode))
 '(package-vc-selected-packages '((org-mode :url "https://code.tecosaur.net/tec/org-mode"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
