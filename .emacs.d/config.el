(use-package vterm
  :ensure t
  )
(use-package multi-vterm
  :ensure t)

(use-package which-key
  :ensure t
  :init
  (which-key-mode)) ;;ensure t makes sure this package is installed

(defalias 'yes-or-no-p 'y-or-n-p)

(setq ring-bell-function 'ignore) ;;annoying bell turned off

(setq make-backup-file nil) ;; no backups
(setq auto-save-default nil) ;; no autosaves

(global-hl-line-mode -1) ;; highlights cursor line

(global-prettify-symbols-mode t) ;; prettify symbols like lambda

(tool-bar-mode -1) ;; removes tool bar
(menu-bar-mode -1) ;; removes menu bar
(scroll-bar-mode -1) ;;removes scroll bar

(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)

(defun rq-kill-buffer ()
  "kill the current buffer without prompt"
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'rq-kill-buffer)

;; relative numbers even in org mode with bullets 
(setq display-line-numbers-type 'visual)
(global-display-line-numbers-mode)

(global-set-key (kbd "C-c a") 'beginning-of-buffer)
(global-set-key (kbd "C-c e") 'end-of-buffer)

(global-set-key (kbd "M--") 'count-words)

(global-set-key (kbd "M-o") 'mode-line-other-buffer)

;; This option shows matched numbers position out of total matches
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
;; Make regular Isearch interpret the empty space as a regular
;; expression that matches any character between the words you give it
(setq search-whitespace-regexp ".*?")

(setq-default mode-line-format
	      '("%e" ;some information may appear in the echo area if content too long
		my-modeline-buffer-name
		"    "
		my-modeline-major-mode

		))

(defvar-local my-modeline-buffer-name
    '(:eval
      (propertize (buffer-name) 'face 'warning))	
  "Mode line construct to display the buffer mode."
  )

(defun my-modeline-major-mode-name ()
  "Return capitalized 'major-mode'"
  (capitalize (string-replace "-mode" "" (symbol-name major-mode)))
  )

(defvar-local my-modeline-major-mode
    '(:eval
      (when (mode-line-window-selected-p)
	(list
	 (propertize "λ" 'face 'shadow)
	 " "
	 (propertize  (my-modeline-major-mode-name) 'face 'bold))
	)
      "Mode line construct to display the major mode."))



(dolist (construct '(my-modeline-major-mode
		     my-modeline-buffer-name))
  (put construct 'risky-local-variable t))

(defun display-custom-time-format ()
  "Display the current time formatted as YYYY-MM-DD HH:MM:SS in the echo area."
  (interactive)
  (message (format-time-string "%a %B, %d %H:%M")))
(display-custom-time-format)






(mode-line-window-selected-p)
(defun mode-line-window-selected-p()
  "Return non-nil if we're updating the mode line for the selected window.
This function is meant to be called in `:eval' mode line constructs
to allow altering the look of the mode line depending on whether the mode line
belongs to the currently selected window or not."
  (let ((window (selected-window)))
    (or (eq window (old-selected-window))
	(and (minibuffer-window-active-p (minibuffer-window))
	     (with-selected-window (minibuffer-window)
	       (eq window (minibuffer-selected-window)))))))

(server-start)

(use-package beacon
  :ensure t
  :init 
  (beacon-mode 1))

(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(global-set-key (kbd "C-c s") 'org-edit-src-code)

(setq org-babel-python-command "python3")
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)))

(global-set-key (kbd "C-c l") 'org-store-link)

(add-hook 'org-mode-hook (lambda ()
			   (setq fill-collumn 120)
			   (auto-fill-mode 1)))

(defun mda/org-open-current-window ()                                              
  "Opens file in current window."                                                  
  (interactive)                                                                    
  (let ((org-link-frame-setup (cons (cons 'file 'find-file) org-link-frame-setup)))
    (org-open-at-point)))                  
(define-key global-map (kbd "C-c o") #'mda/org-open-current-window)

(defun toggle-org-hide-emphasis-markers ()
  "Toggle value of org=hide-emphasis-markers`"
  (interactive)
  (setq org-hide-emphasis-markers (not org-hide-emphasis-markers))
  (org-mode-restart))

(setq org-directory "~/Nextcloud/org")

(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
(setq org-highlight-latex-and-related '(latex))

;; %?  is a placeholder for your cursor
;; %i  is a placeholder for inserting selected text, or none if nothing is selected
;; %a  is a placeholder for inserting a link to the location from the file that the capture was created
(use-package org-capture
  :ensure nil
  :bind ("C-c c" . org-capture)
  :config
  (require 'org)
  (setq org-capture-templates
	`(("w" "Add to the wishlist (may do some day)" entry
	   (file+headline "tasks.org" "Wishlist")
	   ,(concat "* %^{Title}\n"
		    ":PROPERTIES:\n"
		    ":CAPTURED: %U\n"
		    ":END:\n\n"
		    "%?")
	   :empty-lines-after 1)
	  ("u" "Unprocessed" entry
	   (file+headline "tasks.org" "Unprocessed")
	   ,(concat "* %^{Title}\n"
		    ":PROPERTIES:\n"
		    ":CAPTURED: %U\n"
		    ":END:\n\n"
		    "%i%?")
	   :empty-lines-after 1)
	  ("t" "TODO" entry
	   (file+headline "tasks.org" "Tasks with a date")
	   ,(concat "* TODO %^{Title} %^g\n"
		    "%^{How time sensitive it is|SCHEDULED|DEADLINE}: %^t\n"
		    ":PROPERTIES:\n"
		    ":CAPTURED: %U\n"
		    ":END:\n\n"
		    "%i%?")
	   :empty-lines-after 1)
	  ("h" "Habits" entry
	   (file+headline "tasks.org" "Habits")
	   ,(concat "* TODO %^{Title}\n"
		    "%^{|SCHEDULED}: %^t\n"
		    ":PROPERTIES:\n"
		    ":STYLE:    habit\n"
		    ":CAPTURED: %U\n"
		    ":END:\n\n"
		    "%i%?")
	   :empty-lines-after 1)
	  ("f" "Fitness Tracking" entry
	   (file+datetree "fit.org")
	   ,(concat "* %^{What kind of activity|Run|Workout} \n"		    
		    ":PROPERTIES:\n"
		    ":CAPTURED: %U\n"
		    ":END:\n\n"
		    "%?")
	   :empty-lines-after 1
	   :tree-type week)
	  )))

(use-package org-agenda
  :ensure nil
  :bind ("C-c A" . org-agenda)
  :config
  (setq org-agenda-include-diary t)
  (setq org-agenda-files `(,org-directory))



  ;; habits
  (require 'org-habit)
  (setq org-habit-graph-column 50)
  (setq org-habit-preceding-days 9)
  (setq org-habit-show-all-today t)
  )

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;; Example configuration for Consult
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
	 ("C-c M-x" . consult-mode-command)
	 ("C-x C-b". consult-buffer)
	 ("M-s M-l". consult-line)
	 ("M-s M-g". consult-grep)
	 ("M-s M-o". consult-outline)
	 )
  )

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim))
  :init
  )

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package denote
  :ensure t
  :config
  (setq denote-directory '"~/Nextcloud/Documents/publicNotes")
  ;; set the order of denote naming scheme
  (setq denote-file-name-components-order '(signature title keywords identifier))      

  ;; Variant of `my-denote-region' to reference the source
  (defun my-denote-region-get-source-reference ()
    "Get a reference to the source for use with `my-denote-region'.
  The reference is a URL or an Org-formatted link to a file."
    ;; We use a `cond' here because we can extend it to cover more
    ;; cases.
    (cond
     ((derived-mode-p 'eww-mode)
      (plist-get eww-data :url))
     ;; Here we are just assuming an Org format.  We can make this more
     ;; involved, if needed.
     (buffer-file-name
      (format "[[file:%s][%s]]" buffer-file-name (buffer-name)))))

  (defun my-denote-region (&optional lst)
    "Call `denote-subdirectory-signature-title-keywords' and insert therein the text of the active region.
If LST is not provided, use the default list '(title signature)."
    (declare (interactive-only t))
    (interactive)
    (let ((denote-prompts (or lst '(subdirectory signature title keywords))))  ;; Use LST or default '(title signature)
      (if-let (((region-active-p))
	       ;; Capture the text early, otherwise it will be empty
	       ;; the moment `insert` is called.
	       (text (buffer-substring-no-properties (region-beginning) (region-end))))
	  (progn
	    (let ((denote-ignore-region-in-denote-command t))
	      (call-interactively #'denote))
	    (push-mark (point))
	    (insert text)
	    (run-hook-with-args 'denote-region-after-new-note-functions (mark) (point)))
	;; If no region is active, just call `denote` with the prompt list.
	(call-interactively #'denote))))

  (defun my-denote-region-with-reference-zk ()
    "Like `denote-region', but add the context afterwards.
    For how the context is retrieved, see `my-denote-region-get-source-reference'."
    (interactive)
    (let ((context (my-denote-region-get-source-reference))
	  (denote-directory "~/Nextcloud/Documents/publicNotes/"))
      (my-denote-region '(signature title keywords))
      (when context
	(goto-char (point-max))
	(insert "\n")
	(insert context))))

  (defun my-denote-inbox ()
    "Create a simple post note, something you might want to remember,
  everything goes"
    (declare (interactive-only t))
    (interactive)
    (let ((denote-directory "~/Nextcloud/Documents/publicNotes/inbox")
	  (denote-infer-keywords nil)
	  (denote-known-keywords '("fleeting"))
	  (denote-prompts '(title keywords)))
      (call-interactively 'denote)))

  (defun my-denote-zk ()
    "Create the main zettelkasten note"
    (declare (interactive-only t))
    (interactive)
    (let ((denote-directory "~/Nextcloud/Documents/publicNotes/")
	  (denote-prompts '(signature title keywords)))
      (call-interactively 'denote)))

  (defun my-denote-reference ()
    "Create a reference note"
    (declare (interactive-only-t))
    (interactive)
    (let ((denote-directory "~/Nextcloud/Documents/publicNotes/references/")
	  (denote-infer-keywords nil)
	  (denote-known-keywords '("reference" "book"))
	  (denote-prompts '(title keywords)))
      (call-interactively 'denote)))

  (defun my-denote-curated ()
    "Create a curated Note, a well established thought, an article"
    (declare (interactive-only t))
    (interactive)
    (let ((denote-directory "~/Nextcloud/Documents/publicNotes/curated")
	  (denote-infer-keywords nil)
	  (denote-known-keywords '("curated"))
	  (denote-prompts '(title keywords)))
      (call-interactively 'denote)))

  )
(global-set-key (kbd "C-c M-j") 'denote-journal-extras-new-or-existing-entry)

(require 'denote-silo-extras)
(setq denote-journal-extras-title-format 'day-date-month-year)
;; I will refer to this variable for accessing my silos
(setq denote-silo-extras-directories '("~/Nextcloud/Documents/privateNotes"))
(require 'denote-journal-extras)
(setq denote-journal-extras-directory '"~/Nextcloud/Documents/publicNotes/journal/")


(defvar my-denote-commands-for-silos
  '(denote
    denote-date
    denote-subdirectory
    denote-template
    denote-type
    denote-signature
    )
  "List of Denote commands to call after selecting a silo.
  This is a list of symbols that specify the note-creating
  interactive functions that Denote provides.")

(defun my-denote-pick-silo-then-command (silo command)
  "Select SILO and run Denote COMMAND in it.
  SILO is a file path from `my-denote-silo-directories', while
  COMMAND is one among `my-denote-commands-for-silos'."
  (interactive
   (list (completing-read "Select a silo: " denote-silo-extras-directories nil t)
	 (intern (completing-read
		  "Run command in silo: "
		  my-denote-commands-for-silos nil t))))
  (let ((denote-directory silo))
    (call-interactively command)))

(use-package dired
  :ensure nil
  :commands (dired)
  :bind (:map dired-mode-map
	      ("C-c p" . dired-preview-mode)) ;; toggles prot's preview-mode
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches ;; I have disabled the -v flag because
	;; freebsd doesnt have that option
	"-AFGhlv --group-directories-first --time-style=long-iso"))

(use-package dired
  :ensure nil
  :commands (dired)
  :config
  (setq dired-auto-revert-buffer #'dired-directory-changed-p)
  (setq dired-make-directory-clickable t)
  (setq dired-free-space nil)
  (setq dired-mouse-drag-files t)
  (add-hook 'dired-mode-hook #'dired-hide-details-mode)
  (add-hook 'dired-mode-hook #'hl-line-mode)
  (define-key dired-jump-map (kbd "j") nil))

(use-package dired-aux
  :ensure nil
  :bind
  (:map dired-mode-map
	("C-+" . dired-create-empty-file)
	("M-s f" . nil))
  :config
  (setq dired-isearch-filenames 'dwim)
  (setq dired-create-destination-dirs 'ask)
  (setq dired-vc-rename-file t)
  (setq dired-do-revert-buffer (lambda (dir) (not (file-remote-p dir))))
  (setq dired-create-destination-dirs-on-trailing-dirsep t))

(use-package dired-x
  :ensure nil
  :after dired
  :bind
  (:map dired-mode-map
	("I" . dired-info))
  :config
  (setq dired-clean-up-buffer-too t)
  (setq dired-clean-confirm-killing-deleted-buffers t)
  (setq dired-x-hands-off-my-keys t)
  (setq dired-bind-man nil)
  (setq dired-bind-info nil))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package dired-preview
  :ensure t
  :config
  (setq dired-preview-delay 0.1)
  )

(use-package tex
  :ensure auctex)

(use-package laas
  :ensure t
  :hook ((org-mode LaTeX-mode) . laas-mode)
  :config ; do whatever here
  (defun my-laas-beginning-of-line-condition()
    "Return t if snippet key is at the beginning of line"
    (interactive)
    (looking-back "^dm" nil))
  (aas-set-snippets 'laas-mode 
    ;; set condition!
    :cond #'texmathp ;; expand only while in math
    "lim" '(yas "\\lim_{x\\to\\infty} $0")
    "cap" '(yas "\\cap$1")		      
    "cup" '(yas "\\cup$1")
    "ceil" '(yas "\\lceil $1 \\rceil $0")
    "flr" '(yas "\\lfloor $1 \\rfloor $0")
    "cir" "\\circ " ;; composition
    "supp" "\\supp"
    "On" "O(n)"
    "O1" "O(1)"
    "Olog" "O(\\log n)"
    "Olon" "O(n \\log n)"
    ";;{" " \\subseteq "
    "sq" '(yas "\\sqrt{$1} $0")		      
    ;; bind to functions!
    "Sum" (lambda () (interactive)
	    (yas-expand-snippet "\\sum_{n=$1}^{$2} $0"))
    "Span" (lambda () (interactive)
	     (yas-expand-snippet "\\Span($1)$0"))
    ;; add accent snippets
    :cond #'laas-object-on-left-condition
    "qq" (lambda () (interactive) (laas-wrap-previous-object "sqrt"))
    :cond (lambda() (not (texmathp))) ;;expand when not in math 
    "fm" '(yas "\\\\( $1 \\\\)")

    ))

(use-package yasnippet
  :ensure t
  :config
      (yas-global-mode 1))

(setq diary-file "~/Nextcloud/org/diary")

(use-package calendar
  :ensure nil
  :commands (calendar)
  :config
  (setq calendar-latitude 41.08499)
  (setq calendar-longitude 23.54757)
  (setq calendar-location-name "Serres, Greece")
  )

(add-to-list 'load-path "~/.emacs.d/modus-themes")
(require 'modus-themes)
(require 'solar)


;; configure modus themes
(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs nil)

;; Configure modus themes to toggle with the 'modus-themes-toggle' command
(setq modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))

;; Keybinding to toggle between modus vivendi and modus operandi
(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

;; Function to convert current time to decimal representation
(defun current-time-to-decimal ()
  "Return the current time as a floating point number where 18:30 is represented as 18.50."
  (let* ((now (decode-time (current-time)))
	 (hour (nth 2 now))
	 (minute (nth 1 now)))
    (+ hour (/ minute 60.0))))

;; Function to get current date as a list 
(defun current-date()
  "Return the current date as a list of (mont day year)."
  (let* ((now (decode-time (current-time)))
	 (month (nth 4 now))
	 (day (nth 3 now))
	 (year (nth 5 now)))
    (list month day year)))


(setq my-sunrise-sunset (solar-sunrise-sunset (current-date)))

;; Load themes based on current time
(let ((sunrise (car (car my-sunrise-sunset)))
      (sunset (car (cadr my-sunrise-sunset))))
  (if (and (>=  (current-time-to-decimal) sunrise)
	   (< (current-time-to-decimal) sunset))
      (load-theme 'modus-operandi-tinted :no-confirm)
    (load-theme 'modus-vivendi-tinted  :no-confirm)))

(use-package elfeed
  :ensure t
  :bind
  ("C-x e" . elfeed)
  :config
  (setq elfeed-feeds '("https://protesilaos.com/master.xml" "https://rss.reddit.com/r/emacs/")))

(use-package browse-url
  :ensure nil
  :defer t
  :config
  (setq browse-url-browser-function 'eww-browse-url)
  (setq browse-url-secondary-browser-function 'browse-url-default-browser))

(use-package shr
  :ensure nil
  :defer t
  :config
  (setq shr-use-colors nil)             ; t is bad for accessibility
  (setq shr-use-fonts nil)              ; t is not for me
  (setq shr-max-image-proportion 0.6)
  (setq shr-image-animate nil)          ; No GIFs, thank you!
  (setq shr-width fill-column)          ; check `prot-eww-readable'
  (setq shr-max-width fill-column)
  (setq shr-discard-aria-hidden t)
  (setq shr-cookie-policy nil))

(use-package window
  :ensure nil
  :demand t
  :bind
  (:map global-map
	("C-x !" . delete-other-windows-vertically)
	("C-x _" . balance-windows)
	("C-x }" . enlarge-window)
	("C-x {" . shrink-window)
	("C-x >" . enlarge-window-horizontally) ;;override scroll-right
	("C-x <" . shrink-window-horizontally) ;;override scroll-left
	("C-x -" . fit-window-to-buffer)
	))

(use-package markdown-mode
  :ensure t
  :defer t
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package org-anki
  :ensure t
  )

(use-package lsp-mode
  :commands (lsp lsp-deferred) ;; lsp mode gets loaded when lsp, lsp-deferred are triggered
  :init
  (setq lsp-keymap-prefix "C-c C-l")
  :config
  (lsp-enable-which-key-integration t)
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-ui-sideline-enable nil))


;; na allaksw to keybind

(use-package python-mode
  :mode "\\.py\\'"
  :hook (python-mode . lsp-deferred)
  :config
  (setq python-indent-level 4))

(use-package php-mode
  :mode "\\.php\\'"
  :hook (php-mode . lsp-deferred)
  :config
  (setq php-indent-level 4))

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp-deferred))
(add-to-list 'exec-path "~/.cargo/bin")

(add-hook 'python-mode-hook #'tree-sitter-hl-mode)
(add-hook 'php-mode-hook #'tree-sitter-hl-mode)

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
	      ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)  

  )

(add-to-list 'load-path "~/.emacs.d/clip2org/")
(require 'clip2org)
(setq clip2org-clippings-file "~/Downloads/My Clippings.txt")

(use-package mu4e
  :ensure nil
  ;; we do ensure nil because we are using the mu4e installed by the package manager
  ;; of our linux distribution
  ;; we might need to add a load path
  :load-path "/usr/share/emacs/site-lisp/elpa-src/mu4e-1.8.14/"
  :config
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/.mail/uni/")

  (setq mu4e-drafts-folder "/uni/Drafts")
  (setq mu4e-sent-folder "/uni/Sent Items")
  (setq mu4e-refile-folder "/uni/Archive")
  (setq mu4e-trash-folder "/uni/Deleted Items")

  (setq mu4e-maildir-shortcuts
	'(("/uni/Inbox" . ?i)
	  ("/uni/Deleted Items" . ?t)
	  ("/uni/Drafts" . ?d)
	  ("/uni/Archive" . ?a)
	  ("/uni/Sent Items" . ?s)))
  )

;;; Call the oauth2ms program to fetch the authentication token
(require 'cl-lib)
(require 'smtpmail)



(defun fetch-access-token ()
  (with-temp-buffer
    (call-process "oauth2ms" nil t nil "--encode-xoauth2")
    (buffer-string)))


   ;;; Add new authentication method for xoauth2
(cl-defmethod smtpmail-try-auth-method
  (process (_mech (eql xoauth2)) user password)
  (let* ((access-token (fetch-access-token)))
    (smtpmail-command-or-throw
     process
     (concat "AUTH XOAUTH2 " access-token)
     235)))

   ;;; Register the method
(with-eval-after-load 'smtpmail
  (add-to-list 'smtpmail-auth-supported 'xoauth2))

;;smtp config
(setq smtpmail-smtp-server "smtp.office365.com"
      smtp-default-smtp-server "smtp.office365.com"
      smtpmail-smtp-service 587
      smtpmail-stream-type 'starttls
      message-send-mail-function 'smtpmail-send-it
      smtpmail-auth-credentials nil)

;;
(setq user-mail-address "std154940@ac.eap.gr"
      user-full-name "Georgios Kiriazidis")

(setq smtpmail-debug-info t)
(setq smtpmail-debug-verb t)

(use-package magit
:ensure t)
