#!/bin/bash

dotfilesDir=$HOME/.dotfiles/dotfiles_dir

cd $dotfilesDir

for file in .??*; do
	echo $file
	ln -sdf $dotfilesDir/$file $HOME/$file
done

