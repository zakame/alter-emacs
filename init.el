;;; init.el --- bootstrap our Emacs!

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License,
;; or (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

;;; Commentary:

;; This is a very short init.el which loads the real configuration from
;; our README.org.

;;; Code:

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
