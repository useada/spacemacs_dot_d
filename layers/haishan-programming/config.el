;;; config.el --- haishan Layer packages File for Spacemacs
;;
;; Copyright (c) 2015-2016 haishan
;;
;; Author: haishan <guanghui8827@gmail.com>
;; URL: https://github.com/haishan/spacemacs-private
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(spacemacs|defvar-company-backends lua-mode)
(spacemacs|defvar-company-backends markdown-mode)
;; (spacemacs|defvar-company-backends org-mode)
(spacemacs|defvar-company-backends nxml-mode)

(spacemacs|defvar-company-backends sh-mode)
(spacemacs|defvar-company-backends shell-script-mode)
(spacemacs|defvar-company-backends makefile-bsdmake-mode)
(spacemacs|defvar-company-backends conf-unix-mode)
(spacemacs|defvar-company-backends json-mode)
(spacemacs|defvar-company-backends graphviz-dot-mode)
(spacemacs|defvar-company-backends typescript-mode)
(spacemacs|defvar-company-backends php-mode)

(spacemacs|add-toggle iimage
  :status iimage-mode
  :on (iimage-mode)
  :off (iimage-mode -1)
  :documentation "Enable iimage mode"
  :evil-leader "oti")

(add-hook 'term-mode-hook 'haishan/ash-term-hooks)


;; reformat your json file, it requires python
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
                             "python -mjson.tool" (current-buffer) t)))




(add-to-list 'auto-mode-alist (cons (concat "\\." (regexp-opt
                                                   '("xml"
                                                     "xsd"
                                                     "rng"
                                                     "xslt"
                                                     "xsl")
                                                   t) "\\'") 'nxml-mode))
(setq nxml-slash-auto-complete-flag t)



(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))



;; return nil to write content to file
(defun haishan/untabify-buffer ()
  (interactive)
  (save-excursion
    (untabify (point-min) (point-max)) nil))

(add-hook 'c++-mode-hook
          #'(lambda ()
             (add-hook 'write-contents-hooks
                       'haishan/untabify-buffer nil t)))

(setq auto-mode-alist
      (append
       '(("\\.mak\\'" . makefile-bsdmake-mode))
       auto-mode-alist))


(defmacro haishan|toggle-company-backends (backend)
  "Push or delete the backend to company-backends"
  (let ((funsymbol (intern (format "zilong/company-toggle-%S" backend))))
    `(defun ,funsymbol ()
       (interactive)
       (if (eq (car company-backends) ',backend)
           (setq-local company-backends (delete ',backend company-backends))
         (push ',backend company-backends)))))
