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
 '(org-agenda-files
   '("/home/rqd3/Documents/publicNotes/references/--emacs-lisp__reference@@20240802T143230.org" "/home/rqd3/Documents/publicNotes/references/--basedonatruestory__book@@20240718T003733.org" "/home/rqd3/Documents/publicNotes/references/--denote__denote@@20240804T230804.org" "/home/rqd3/Documents/publicNotes/references/--doriangray__book@@20240718T003548.org" "/home/rqd3/Documents/publicNotes/references/--good-will-hunting__reference@@20240728T214900.org" "/home/rqd3/Documents/publicNotes/references/--kt__reference@@20240722T182950.org" "/home/rqd3/Documents/publicNotes/references/--matrix__matrix_messenger_protocol@@20240729T131119.org" "/home/rqd3/Documents/publicNotes/references/--rust__programming_rust_tutorial@@20240727T215119.org" "/home/rqd3/Documents/publicNotes/references/--sea-machine__htb@@20240813T215020.org" "/home/rqd3/Documents/publicNotes/references/--thesis__zksnarks@@20240805T235735.org" "/home/rqd3/Documents/publicNotes/references/--zk-number-theory-crypto__reference@@20240808T174812.org" "/home/rqd3/Documents/publicNotes/references/--η-επιστήμη-και-ο-άνθρωπος-ρασελ__book_reference@@20240810T170136.org"))
 '(package-selected-packages
   '(straight screenshot mu4e magit preview-latex laas Org-mode clip2org kindle-highlights-to-org lsp-ui rustic company python-ts-mode tree-sitter-langs tree-sitter lsp-pyright dired-preview org-anki php-mode anki-editor org-fc Org-fc multi-vterm vterm markdown-mode elfeed modus-themes yasnippet which-key vertico use-package spacemacs-theme org-bullets orderless marginalia lv embark-consult dired-sidebar denote cdlatex beacon auctex aas))
 '(package-vc-selected-packages
   '((anki-editor :url "https://github.com/anki-editor/anki-editor"))))
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
