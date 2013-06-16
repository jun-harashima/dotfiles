
;; ロードパスを設定
(add-to-list 'load-path "~/.emacs.d/elisp/")

;; リポジトリを拡張
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; popwin.el を導入
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-position 'bottom)

;; モードラインに Git のブランチを表示
;; http://d.hatena.ne.jp/syohex/20130201/1359731697 から拝借
(let ((cell (or (memq 'mode-line-position mode-line-format)
		(memq 'mode-line-buffer-identification mode-line-format)))
      (newcdr '(:eval (my/update-git-branch-mode-line))))
  (unless (member newcdr mode-line-format)
    (setcdr cell (cons newcdr (cdr cell)))))

(defun my/update-git-branch-mode-line ()
  (let* ((branch (replace-regexp-in-string
                  "[\r\n]+\\'" ""
                  (shell-command-to-string "git symbolic-ref -q HEAD")))
         (mode-line-str (if (string-match "^refs/heads/" branch)
                            (format "[%s]" (substring branch 11))
                          "[Not Repo]")))
    (propertize mode-line-str
                'face '((:foreground "red" :weight bold)))))

;; メニューバーを表示しない
(menu-bar-mode -1)

;; カーソルの位置（行）を表示
(line-number-mode 1)

;; カーソルの位置（列）を表示
(column-number-mode 1)

;; 対応する括弧をハイライト
(show-paren-mode 1)

;; 選択領域に色を付与
(set-face-background 'region "#555")

;; 行末に無駄なスペースがあれば、色を付与
(setq-default show-trailing-whitespace 1)
(set-face-background 'trailing-whitespace "red")

;; バッファの切り替えを helm に変更
(global-set-key (kbd "C-x C-b") 'helm-mini)

;; C-c g で指定した行へ移動
(global-set-key "\C-cg" 'goto-line)

;; M-p で history-beginning-search
(add-hook 'shell-mode-hook
	  '(lambda ()
	     (local-set-key "\M-p" 'comint-previous-matching-input-from-input)
	     ))

;; org-mode で "Validate XHTML 1.0" を表示しない
(setq org-export-html-validation-link -1)

;; テーマを設定
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (manoj-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
