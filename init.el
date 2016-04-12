;;; init.el --- bootstrap our Emacs!

;;; Commentary:

;; This is a very short init.el which loads the real configuration from
;; our README.org.

;;; Code:

;; load our configuration in README.org
(with-temp-buffer
  (insert-file-contents
   (expand-file-name "README.org" user-emacs-directory))
  (goto-char (point-min))
  (while (not (eobp))
    (forward-line 1)
    (cond
     ;; Report headers
     ((looking-at
       (format "\\*\\{2,%s\\} +.*$" 2))
      (message "%s" (match-string 0)))
     ;; Evaluate elisp configuration src blocks
     ((looking-at "^#\\+BEGIN_SRC +emacs-lisp *$")
      (let ((l (match-end 0)))
        (search-forward "\n#+END_SRC")
        (eval-region l (match-beginning 0)))))))

(provide 'init)

;;; init.el ends here
