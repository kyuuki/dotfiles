;;; init.el --- Emacs 設定ファイル

;; コメントの慣習は以下に従う。
;; http://www.bookshelf.jp/texi/elisp-manual/21-2-8/jp/elisp_42.html#SEC665

;;;;
;;;; 全体
;;;;
(setq load-path (append '("~/.emacs.d/lib" "~/.emacs.d/conf") load-path))
(require 'local)
(setq fill-column 120)
(ffap-bindings)

;;; キー割り当て
(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-h") nil)

(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-j") 'newline)
(global-set-key (kbd "C-x n") 'goto-line)
(global-set-key (kbd "C-t") 'other-window)

(winner-mode 1)
(global-set-key (kbd "C-q") 'winner-undo)

;;; Tab 設定
;(setq default-tab-width 4)
;(setq indent-tabs-mode nil)
(setq-default default-tab-width 4)
(setq-default indent-tabs-mode nil)
; setq と setq-default の違いは？
; http://www.geocities.co.jp/SiliconValley-Bay/9285/EMACS-JA/emacs_465.html

;;; 文字コード
; http://yohshiy.blog.fc2.com/blog-entry-273.html
;(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8-unix)

;;; バックアップ
; http://yohshiy.blog.fc2.com/blog-entry-319.html
(setq make-backup-files t)
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)

;;; その他

; gnupack では、サイズを config.ini で設定するのがお作法のようだ。

;; 起動時の画面を非表示にする。
(setq inhibit-startup-message t)

;; ツールバー非表示
;(tool-bar-mode nil)  ; Emacs 24 では表示されてしまう。
(when window-system
  (tool-bar-mode 0))

;; ビープ音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#f88"
                    :height 0.9)

;; 行番号フォーマット
; http://d.hatena.ne.jp/sandai/20120304/p2
(setq linum-format "%4d ")

;; インデントして、次の行に移動する (M-n に割り当て)。
(defun indent-and-next-line ()
  (interactive)

  (indent-according-to-mode)
  (next-line 1))
(global-set-key (kbd "M-n") 'indent-and-next-line)

;;; Shell

;; Cygwin の bash を使う場合
(setq explicit-shell-file-name "bash")
(setq shell-file-name "sh")
(setq shell-command-switch "-c")

;; shell-modeでの補完 (for drive letter)
(setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@'`.,;()-")

;;;;
;;;; 各モード
;;;;

;;; web-mode

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(add-hook 'web-mode-hook  'web-mode-hook)

;; 色の設定
(custom-set-faces
 '(web-mode-doctype-face
   ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face
   ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-html-attr-name-face
   ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face
   ((t (:foreground "#82AE46"))))
 '(web-mode-comment-face
   ((t (:foreground "#D9333F"))))
 '(web-mode-server-comment-face
   ((t (:foreground "#D9333F"))))
 '(web-mode-css-rule-face
   ((t (:foreground "#A0D8EF"))))
 '(web-mode-css-pseudo-class-face
   ((t (:foreground "#FF7F00"))))
 '(web-mode-css-at-rule-face
   ((t (:foreground "#FF7F00"))))
 )

;;; html-mode

(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 2)
            (setq indent-tabs-mode nil)))

;;; ruby-mode

;; Ruby のエンコーディング対策
; http://d.hatena.ne.jp/arikui1911/20091126/1259217255
;(add-to-list 'ruby-encoding-map '(japanese-cp932 . cp932))
; http://atssh-knk.iobb.net/blog/
(add-hook 'ruby-mode-hook
          '(lambda ()
             (add-to-list 'ruby-encoding-map '(japanese-cp932 . cp932))
             (add-to-list 'ruby-encoding-map '(undecided . cp932))
             )
          )

;;; markdown-mode

(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.rd" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;;;
;;;; 各 Emacs Lisp 設定
;;;;

;;; パッケージ管理

(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;;; auto-install (元 install-elisp.el)

; Emacs 実践入門
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/lib")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))

;;; howm

;; (setq load-path (cons "~/.emacs.d/lib/howm" load-path))
;; (when (require 'howm nil t)
;;   (autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)
;;   (global-set-key "\C-c,," 'howm-menu)
;;   (setq howm-menu-lang 'ja)
;;   (setq howm-directory local-howm-directory)

;;   ; http://blechmusik.hatenablog.jp/entry/2013/07/09/015124
;;   ;(setq howm-view-use-grep t)
;;   ;(setq howm-process-coding-system 'utf-8-unix)

;;   (setq howm-view-external-viewer-assoc
;;         '(("[.]\\(chm\\|djvu\\|html\\|exe\\|ps\\|gz\\|rar\\|zip\\|jpg\\|mp3\\|gif\\|png\\|pdf\\|doc\\|xls\\|ppt\\)$" . "fiber.exe %s")
;;           ("[.]dvi$" . "dviout %s"))))


;;; anything

; Emacs 実践入門
; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   anything-idle-delay 0.3
   anything-input-idle-delay 0.2
   anything-candidate-number-limit 100
   anything-quick-update t
   anything-enable-shortcuts 'alphabet)

  (global-set-key (kbd "C-;") 'anything)

  (when (require 'anything-config nil t)
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    (descbinds-anything-install)))

;;; lookup

;; オートロードの設定
(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)

;; キーバインドの設定
(define-key ctl-x-map "l" 'lookup)            ; C-x l - lookup
(define-key ctl-x-map "y" 'lookup-region)     ; C-x y - lookup-region
(define-key ctl-x-map "\C-y" 'lookup-pattern) ; C-x C-y - lookup-pattern

(setq lookup-search-agents '((ndeb "C:/share/dic/GENIUS/")
                             (ndeb "C:/share/dic/LDOCE4/")
                             (ndeb "C:/share/dic/SP2000/")))

;;; YaTeX

(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq tex-command "c:/usr/local/bin/platex")
(setq dvi2-command "c:/usr/dviout/dviout")

;;; 関数一覧 (navi)

;(load-library "navi")
(global-set-key [f11] 'call-navi)
;(global-set-key "\C-x\C-l" 'call-navi)
(defun call-navi ()
  (interactive)
  (navi (buffer-name)))

;;;;
;;;; 小物
;;;;

;; テンプレート
(setq auto-insert-directory "C:/data/template/")
(auto-insert-mode 1)
(setq auto-insert-query nil)
(setq auto-insert-alist
      (append '(
                ("\\.rb$" . "template.rb")
                ("\\.pl$" . "template.pl")
                ("\\.js$" . "template.js")
                ("\\.h$" . "template.h")
                ("\\.c$" . "template.c")
                ("\\.cpp$" . "template.cpp")
                ) auto-insert-alist))

;; タブ、全角スペース、改行直前の半角スペースを表示する。
; http://homepage3.nifty.com/satomii/software/elisp.ja.html
; jaspace.el に以下の修正を入れている
; http://d.hatena.ne.jp/minazoko/20110307/1299516769
(when (require 'jaspace nil t)
  (when (boundp 'jaspace-modes)
    (setq jaspace-modes (append jaspace-modes
                                (list 'php-mode
                                      'yaml-mode
                                      'javascript-mode
                                      'ruby-mode
                                      'text-mode
                                      'fundamental-mode))))
  (when (boundp 'jaspace-alternate-jaspace-string)
    (setq jaspace-alternate-jaspace-string "□"))
  (when (boundp 'jaspace-highlight-tabs)
    (setq jaspace-highlight-tabs ?^))
  (add-hook 'jaspace-mode-off-hook
            (lambda()
              (when (boundp 'show-trailing-whitespace)
                (setq show-trailing-whitespace nil))))
  (add-hook 'jaspace-mode-hook
            (lambda()
              (progn
                (when (boundp 'show-trailing-whitespace)
                  (setq show-trailing-whitespace t))
                (face-spec-set 'jaspace-highlight-jaspace-face
                               '((((class color) (background light))
                                  (:foreground "blue"))
                                 (t (:foreground "green"))))
                (face-spec-set 'jaspace-highlight-tab-face
                               '((((class color) (background light))
                                  (:foreground "red"
                                   :background "unspecified"
                                   :strike-through nil
                                   :underline t))
                                 (t (:foreground "purple"
                                     :background "unspecified"
                                     :strike-through nil
                                     :underline t))))
                (face-spec-set 'trailing-whitespace
                               '((((class color) (background light))
                                  (:foreground "red"
                                   :background "unspecified"
                                   :strike-through nil
                                   :underline t))
                                 (t (:foreground "purple"
                                     :background "unspecified"
                                     :strike-through nil
                                     :underline t))))))))

;; http://www.bookshelf.jp/soft/meadow_37.html#SEC554
(defvar my-template-text-file "~/.template")
(defvar my-template-buffer nil)
(defvar my-template-point nil)

(defun my-template-insert ()
  (interactive)
  (let (content)
    (when (setq
           content
           (get-text-property (point) :content))
      (save-excursion
        (set-buffer my-template-buffer)
        (save-excursion
          (goto-char my-template-point)
          (insert content))))))

(defun my-template-select ()
  (interactive)
  (let ((buffer
         (get-buffer-create "*select template*"))
        templates begin template-map text)
    (setq my-template-buffer (current-buffer)
          my-template-point  (point))
    (unless (file-readable-p my-template-text-file)
      (error "Couldn't read template file: %s"))
    (with-temp-buffer
      (insert-file-contents my-template-text-file)
      (goto-char (point-min))
      (while (re-search-forward "^\\*\\{3\\}\\(.*\\)$" nil t)
        (when begin
          (setq templates
                (cons
                 (cons
                  (car templates)
                  (buffer-substring
                   begin (1- (match-beginning 0))))
                 (cdr templates))))
        (setq templates (cons (match-string 1) templates))
        (setq begin (1+ (match-end 0))))
      (when begin
        (setq templates
              (cons
               (cons
                (car templates)
                (buffer-substring begin (point-max)))
               (cdr templates)))))
    (pop-to-buffer buffer)
    (setq buffer-read-only nil
          major-mode       'template-select-mode
          mode-name        "Select Template"
          template-map     (make-keymap))
    (suppress-keymap template-map)
    (define-key template-map " "    'my-template-insert)
    (define-key template-map "\C-m" 'my-template-insert)
    (define-key template-map "n"    'next-line)
    (define-key template-map "p"    'previous-line)
    (define-key template-map "q"    'kill-buffer-and-window)
    (use-local-map template-map)
    (buffer-disable-undo)
    (delete-region (point-min) (point-max))
    (dolist (tt templates)
      (setq text (concat (car tt) "\n"))
      (put-text-property
       0 (length text) :content (cdr tt) text)
      (insert text)
      (goto-char (point-min)))
    (delete-region (1- (point-max)) (point-max))
    (setq buffer-read-only t)
    (set-buffer-modified-p nil)))
(define-key global-map "\C-cT" 'my-template-select)

;; http://www.bookshelf.jp/soft/meadow_37.html#SEC548
(autoload 'instamp
  "instamp" "Insert TimeStamp on the point" t)
(setq instamp-date-format-list-private
      '("%Y-%m-%d" "(%H:%M)"))
(define-key global-map "\C-ct" 'instamp)

;; ファイルを Windows の関連付けで開く
; http://ratememo.blog17.fc2.com/blog-entry-734.html
(defun my-file-open-by-windows (file)
  "ファイルを Windows の関連付けで開く"
  (interactive "fOpen File: ")
  (message "Opening %s..." file)
  (cond ((not window-system)
           ; window-system => w32と表示される
         )
        ((eq system-type 'windows-nt)
           ; XPではwindows-ntと表示される
           ; infile:      標準入力
           ; destination: プロセスの出力先
           ; display:     ?
         (call-process "cmd.exe" nil 0 nil "/c" "start" "" (convert-standard-filename file))
         )

        ((eq system-type 'darwin)
         (call-process "open" nil 0 nil file)
         )

        (t
         (call-process "xdg-open" nil 0 nil file)
         )
        )

  (recentf-add-file file)
  (message "Opening %s...done" file)
  )
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "x" 'my-file-open-by-windows)))

