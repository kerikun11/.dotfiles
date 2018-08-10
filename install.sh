#!/bin/bash

dotfilesDir=$HOME/.dotfiles/.config

cd $dotfilesDir

for file in .??*; do
	echo $file
	ln -sdf $dotfilesDir/$file $HOME/$file
done

