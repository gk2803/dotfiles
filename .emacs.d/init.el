(require 'package)
(setq package-enable-at-startup nil)
;; (setq debug-on-error t)		
;; adds melpa packages to package-list
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)	     

(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages") t)
;; makes it easy to install other packages 
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package org
    :load-path "~/.emacs.d/elpa/org-mode/lisp/")



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 145 :width normal :foundry "PfEd" :family "Ubuntu Mono")))))
 
;; font and stuff

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(clip2org-include-date t)
 '(custom-safe-themes
   '("30d174000ea9cbddecd6cc695943afb7dba66b302a14f9db5dd65074e70cc744" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1" "11819dd7a24f40a766c0b632d11f60aaf520cf96bd6d8f35bae3399880937970" "9a977ddae55e0e91c09952e96d614ae0be69727ea78ca145beea1aae01ac78d2" "e410458d3e769c33e0865971deb6e8422457fad02bf51f7862fa180ccc42c032" "c7a926ad0e1ca4272c90fce2e1ffa7760494083356f6bb6d72481b879afce1f2" "7613ef56a3aebbec29618a689e47876a72023bbd1b8393efc51c38f5ed3f33d1" "1ea82e39d89b526e2266786886d1f0d3a3fa36c87480fad59d8fab3b03ef576e" default))
 '(elfeed-feeds
   '("https://www.reddit.com/r/Boxing/hot.rss" "reddit.com/r/boxing/.rss" "https://news.ycombinator.com/rss"))
 '(org-agenda-files
   '("~/Nextcloud/Documents/publicNotes/references/20250211T201751--agores.org"))
 '(package-selected-packages
   '(smartparens denote-journal org-agenda doom-themes ox-hugo python-pytest pyvenv direnv python-mode org-habit-stats gptel org-mode))
 '(package-vc-selected-packages '((org-mode :url "https://code.tecosaur.net/tec/org-mode"))))

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


