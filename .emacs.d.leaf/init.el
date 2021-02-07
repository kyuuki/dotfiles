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

;;;; 表示
(if window-system
  (tool-bar-mode 0)
  (menu-bar-mode -1)
)

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

(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(blackout el-get hydra leaf-keywords leaf)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
