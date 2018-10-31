#!/bin/bash -x

## constants
dotfilesDir=$HOME/.dotfiles/dotfiles_auto
ohmyzshDir=$HOME/.oh-my-zsh

## install prerequirements
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git zsh vim

## prepare oh-my-zsh
if ! [ -d $ohmyzshDir ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

## link
cd $dotfilesDir
for file in .??*; do
	echo $file
	ln -sdf $dotfilesDir/$file $HOME/$file
done

