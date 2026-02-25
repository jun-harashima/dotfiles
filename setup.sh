#!/bin/bash

# dotfiles セットアップスクリプト
# 新しい Mac の初期設定を自動化する
#
# Requirements:
# - Command Line Tools (git clone 前にインストール済みのはず)

set -e  # エラーが発生したら終了

echo "======================================"
echo "  dotfiles セットアップを開始します"
echo "======================================"
echo ""

# スクリプトのディレクトリを取得
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

###############################################################################
# Homebrew のインストール
###############################################################################

echo "[1/2] Homebrew の確認..."
if ! command -v brew &> /dev/null; then
    echo "Homebrew をインストールしています..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # PATH を設定
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✓ Homebrew はインストール済みです"
fi

###############################################################################
# Brewfile からパッケージをインストール
###############################################################################

echo ""
echo "[2/2] Homebrew パッケージをインストール..."
if [ -f "$SCRIPT_DIR/Brewfile" ]; then
    brew bundle --file="$SCRIPT_DIR/Brewfile"
    echo "✓ パッケージのインストールが完了しました"
else
    echo "警告: Brewfile が見つかりません"
fi

###############################################################################
# 完了
###############################################################################

echo ""
echo "======================================"
echo "  セットアップが完了しました！"
echo "======================================"
echo ""
