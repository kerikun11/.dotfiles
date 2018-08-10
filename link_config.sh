#!/bin/bash

dotfilesDir=$HOME/.dotfiles/link_config_dir

cd $dotfilesDir

for file in .??*; do
	echo $file
	ln -sdf $dotfilesDir/$file $HOME/$file
done

