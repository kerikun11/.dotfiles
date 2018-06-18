#!/bin/bash

SCRIPT_DIR = $(cd $(dirname $0); pwd)

for file in .??*
do
	echo $file
	# シンボリックリンクを作成
	ln -sdf $HOME/.dotfiles/$file $HOME/$file
	# 文字コードをUTF-8に
	nkf -Lu --overwrite $file
done

# cp -rs $(find $(pwd) -maxdepth 1 | grep -P '^'$(pwd)'\/\.(?!git)') $HOME