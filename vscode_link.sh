#!/bin/bash

dotfilesDir=$HOME/.dotfiles/vscode_auto

cd $dotfilesDir

for file in *; do
	echo $file
	ln -sdf $dotfilesDir/$file $HOME/.config/Code/User/$file
done

