;; yas-edit.el -- Quickly edit yas snippets
;; Copyright Facet (facet@facetframer.com https://facetframer.com/)
;; GPLv3


(require 'yasnippet)

(defvar yas-edit-callback nil)
(defvar yas-edit-last nil "The last snippet expanded")

(defun yas-edit (prefix)
 (interactive "P")
 (let (
       (snippet (if (null prefix) (read-from-minibuffer "Snippet name:" yas-edit-last) prefix))

       (mode major-mode)
       ;; damn newlines
       )
   (find-file (concat (car yas/root-directory) "/" (symbol-name major-mode) "/" snippet))
   (message "Recursive edit. Exit recursive edit when done")
   (funcall mode)

   (let ((require-final-newline nil))
     (if yas-edit-callback
         (funcall yas-edit-callback))
     (recursive-edit))
   (kill-buffer)
   (yas/reload-all)))

(defun yas-edit-repeat ()
  "Repeat the last expansion"
  ;; Horrible hack
  (interactive)
  (evil-insert nil)
  (insert yas-edit-last)
  (yas-expand))

(defun yas-edit-last ()
  "Edit the last thing that yas expanded"
  (interactive)
  (yas-edit yas-edit-last))

(defun yas-expand-or-edit ()
  "Expand the word before the point or define a mapping"
  (interactive)
  (setq yas-edit-last (buffer-substring-no-properties (point) (save-excursion (backward-word) (point))))
  (let ((expand-point (save-excursion (if
                                          (equal (yas-expand) t)
                                          (point) nil))))
    ;; HACK - this is not what yas does
    (if
        (equal expand-point nil)
        (progn
          (yas-edit (symbol-name (symbol-at-point)))
          (yas-expand))
      (goto-char expand-point))))


(provide 'yas-edit)
