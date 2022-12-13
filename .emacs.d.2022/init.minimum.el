;;; init.el --- Emacs 設定ファイル 2022  -*- lexical-binding: t; -*-

;; コメント慣習
;; https://ayatakesi.github.io/lispref/28.2/html/Comment-Tips.html

;; 定番の C-h が効かないとめちゃくちゃ不便 (このキーバインドに慣れすぎてる)。
;; https://akisute3.hatenablog.com/entry/20120318/1332059326
;; https://oversleptabit.com/archives/5685
(keyboard-translate ?\C-h ?\C-?)

;; 最初にブックマークがないのが一番不便 (ブラウザでも同様)。
;; (逆にこれだけあればメモが開けるので、最低限の Emacs 活動ができる)
(setq bookmark-default-file "xxx/txt/bookmarks")

;; URL をサクッと開きたい。
(ffap-bindings)

;; アラーム音
(setq visible-bell t)			; Mac だと気持ち悪い
;(setq ring-bell-function 'ignore)	; のでこちらは完全無視

;; バックアップファイル (自動作成ファイル)
;; http://yohshiy.blog.fc2.com/blog-entry-319.html
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)

;; キーバインド (全体)
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-j") 'newline)
(global-set-key (kbd "C-x n") 'goto-line)
(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "C-c l") 'org-store-link) ; Org-mode 関係だけど

;; フォント関係は最低限デフォルトでもなんとかなる。
