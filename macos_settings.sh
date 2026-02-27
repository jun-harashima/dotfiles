#!/bin/bash

# macOS のシステムを設定するスクリプト
# 新しい Mac をセットアップする際に実行する

echo "macOS システム設定を開始します..."

###############################################################################
# Dock の設定
###############################################################################

echo "Dock の設定を適用中..."

# Dock の自動表示/非表示を有効化
defaults write com.apple.dock autohide -bool true

# ホットコーナー：右下をデスクトップに設定
# wvous-br-corner: 右下のコーナー（4 = デスクトップを表示）
# wvous-br-modifier: 修飾キーなし（0）
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# キーボードの設定
###############################################################################

echo "キーボードの設定を適用中..."

# キーリピート速度を最速に設定（2 = 最速）
defaults write NSGlobalDomain KeyRepeat -int 2

# キーリピート開始までの時間を短く設定（15 = 最短）
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# キーボードショートカット
###############################################################################

echo "キーボードショートカットを設定中..."

# Spotlight 検索を無効化
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"

# 前の入力ソースを選択（Command + Space）
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"

###############################################################################
# 設定の反映
###############################################################################

echo "設定を反映しています..."

# Dock を再起動して設定を反映
killall Dock

echo "macOS システム設定が完了しました！"
echo "一部の設定は再起動後に反映されます。"
