#!/bin/bash

# 手動管理
DOTFILES=(.vimrc .zshrc .tmux.conf .gitconfig)

# このディレクトリを原点に環境を構築する
# ので、スクリプトのテストする時はテスト用のディレクトリに変えて
ROOT_DIR=$HOME/

for file in ${DOTFILES[@]}; do
	echo $file
	ln -sfd $HOME/.dotfiles/$file $HOME/$file
	nkf -Lu --overwrite $file
done

