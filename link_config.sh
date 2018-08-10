#!/bin/bash

dotfilesDir=$HOME/.dotfiles/auto_link

cd $dotfilesDir

for file in .??*; do
	echo $file
	ln -sdf $dotfilesDir/$file $HOME/$file
done

