#!/bin/bash

dotfilesDir=$HOME/.dotfiles/dotfiles_auto

cd $dotfilesDir

for file in .??*; do
	echo $file
	ln -sdf $dotfilesDir/$file $HOME/$file
done

