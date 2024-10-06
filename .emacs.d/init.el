(require 'package)
(setq package-enable-at-startup nil)
;; adds melpa packages to package-list
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)	     

;; makes it easy to install other packages 
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


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
   '("c7a926ad0e1ca4272c90fce2e1ffa7760494083356f6bb6d72481b879afce1f2" "7613ef56a3aebbec29618a689e47876a72023bbd1b8393efc51c38f5ed3f33d1" "1ea82e39d89b526e2266786886d1f0d3a3fa36c87480fad59d8fab3b03ef576e" default))
 '(elfeed-feeds
   '("https://www.reddit.com/r/Boxing/hot.rss" "reddit.com/r/boxing/.rss" "https://news.ycombinator.com/rss"))
 '(org-agenda-files nil)
 '(package-selected-packages
   '(CDLaTeX til htmlize straight screenshot mu4e magit preview-latex laas Org-mode clip2org kindle-highlights-to-org lsp-ui rustic company python-ts-mode tree-sitter-langs tree-sitter lsp-pyright dired-preview org-anki php-mode anki-editor org-fc Org-fc multi-vterm vterm markdown-mode elfeed modus-themes yasnippet which-key vertico use-package spacemacs-theme org-bullets orderless marginalia lv embark-consult dired-sidebar denote cdlatex beacon auctex aas))
 '(package-vc-selected-packages
   '((anki-editor :url "https://github.com/anki-editor/anki-editor"))))
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

;; display startup time
;; (defun efs/display-startup-time ()
;;   (message "Emacs loaded in %s with %d garbage collections."
;;            (format "%.2f seconds"
;;                    (float-time
;;                    (time-subtract after-init-time before-init-time)))
;;            gcs-done))

;; (add-hook 'emacs-startup-hook #'efs/display-startup-time)
