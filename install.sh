#!/bin/bash

cd ~/.dotfiles

for file in .??*
do
	[[ "$file" == ".git" ]] && continue
	echo $file
	# シンボリックリンクを作成
	ln -sdf $HOME/.dotfiles/$file $HOME/$file
	# 文字コードをUTF-8に
	nkf -Lu --overwrite $file
done

# cp -rs $(find $(pwd) -maxdepth 1 | grep -P '^'$(pwd)'\/\.(?!git)') $HOME
