;;; init.el --- Emacs Reborn  -*- lexical-binding: t; -*-

;;;; 基本

;;; キーバインド
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-j") 'newline)
(global-set-key (kbd "C-x n") 'goto-line)
(global-set-key (kbd "C-t") 'other-window)

;;; ビープ音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;;; FFAP
(ffap-bindings)

;;;; 日本語

;;; 文字コード
;; http://yohshiy.blog.fc2.com/blog-entry-273.html
(prefer-coding-system 'utf-8-unix)

;;;; leaf

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (if (>= emacs-major-version 26) (leaf blackout :ensure t))

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

(leaf cus-start
  :custom
  (if (window-system) (menu-bar-mode . nil)))

(provide 'init)
