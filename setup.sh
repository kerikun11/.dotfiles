#!/bin/bash

# 手動管理
DOTFILES=(.vimrc .zshrc .tmux.conf .gitconfig)

# このディレクトリを原点に環境を構築する
# ので、スクリプトのテストする時はテスト用のディレクトリに変えて
ROOT_DIR=$HOME/

for file in ${DOTFILES[@]}; do
	echo $file
	ln -sfd $HOME/dotfiles/$file $ROOT_DIR/$file
done

echo "Git clone neobundle"
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

