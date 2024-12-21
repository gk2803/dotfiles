(defcustom my-dict-filename (expand-file-name "~/Documents/english.org")
  "Dictionary's main filepath"
  )

(find-file-noselect "~/Nextcloud/Notes/languages/english.org")
(defun my-dict-buffer-trim-remove-newlines (start end)
  "Removes any newlines from `region-text' and replaces
   the targetted word inside angle brackets <word>
   with a tilde."
  (replace-regexp-in-string "\\(\n\\)" " " (string-trim (buffer-substring-no-properties start end))))


(defun my-dict-extract-word (string)
  "Takes a string as an argument and matches a word inside
angle brackets like this `<word>'. It then procedes to return
said `word'"
  (let ((res-string (if (string-match "<\\(\\w+\\)>" string)
			(match-string 1 string)
		      nil)))
    res-string))  

(defun my-dict-replace-word-with-tilde (string)
  "replaces `<word>' inside angle brackets `word'
with a tilde `~'"
  (replace-regexp-in-string "<\\w+>" "~" string))


(defun my-dict-insert-word (word)
  "Insert a word and its translation into the existing buffer `english.org`."
  (interactive
   (let ((region-text (if (use-region-p)
			  (my-dict-buffer-trim-remove-newlines (region-beginning) (region-end))
			"")))
     (list (read-string "Enter word for translation: " region-text))))

  ;; Get the translation from the user
  (let ((translation (read-string "Enter the translation: ")))
    ;; Open the existing buffer `english.org`
    (with-current-buffer (find-file-noselect my-dict-filename)
      ;; Check if the buffer was opened successfully
      (save-excursion
        ;; Move to the end of the buffer and insert the word and its translation
        (goto-char (point-max))
        (insert (if (my-dict-extract-word word) 
		     (concat "* "
			     (my-dict-extract-word word)
			     "\n"
			     translation
			     "\n"
			     (my-dict-replace-word-with-tilde word))
		   
		   (concat "* "
			   word
			   "\n"
			   translation
			   "\n\n")))
	(save-buffer)))    
    ;; (switch-to-buffer (get-buffer "english.org"))
    ;; (goto-char (point-max))
    ))

(provide 'dict)



