;;; eros-inspector.el --- Glue between eros and inspector  -*- lexical-binding: t -*-

;; Copyright (C) port19

;; Author: port19 <port19@port19.xyz>
;; Version: 1.0.1
;; Package-Requires: ((emacs "24.4") (eros "0.1.0") (inspector "0.38"))
;; SPDX-License-Identifier: LGPL-3.0-or-later
;; Keywords: convenience, lisp, tool, debugging, development
;; Homepage: https://github.com/port19x/eros-inspector
;; URL: https://github.com/port19x/eros-inspector
;; Created: 20 Sep 2024

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package provides glue between the popular elisp development
;; packages eros and inspector.  No longer do you have to choose
;; between an evaluation overlay and a nice representation of
;; evaluation results.

;; `eros-inspector-eval-last-sexp' combines `eros-eval-last-sexp' and
;; `inspector-inspect-last-sexp' `eros-inspector-eval-defun' combines
;; `eros-eval-defun' and `inspector-inspect-defun'

;;; Code:

(require 'eros)
(require 'inspector)

;;;###autoload
(defun eros-inspector-eval-last-sexp (eval-last-sexp-arg-internal)
  "Evaluate sexp before point, then overlay and inspect the result.
Argument EVAL-LAST-SEXP-ARG-INTERNAL is implicit, see `eval-last-sexp'."
  (interactive "P")
  (let ((result (eval-last-sexp eval-last-sexp-arg-internal)))
    (setq eros--last-result result)
    (inspector-inspect result)
    (eros--eval-overlay result (point))))

;;;###autoload
(defun eros-inspector-eval-defun (edebug-it)
  "Evaluate the top sexp, then overlay and inspect the result.
Argument EDEBUG-IT is implicit, see `eval-defun'."
  (interactive "P")
  (let ((result (eval-defun edebug-it)))
    (setq eros--last-result result)
    (inspector-inspect result)
    (eros--eval-overlay result (save-excursion (end-of-defun) (point)))))

(provide 'eros-inspector)

;;; eros-inspector.el ends here
