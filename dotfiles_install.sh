#!/bin/bash
# file          dotfiles_install.sh
# author        Ryotaro Onuki
# created_at    2019.03.13

## debug output
#set -x

## error by undefined variable
set -u

## constants
dotfilesDir=$HOME/.dotfiles/dotfiles_auto
ohmyzshDir=$HOME/.oh-my-zsh

## determine OS
if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    OS='Linux'
elif [ "$(expr substr $(uname -s) 1 5)" == 'MINGW' ]; then
    OS='MINGW'
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi
echo "OS: $OS"

## install prerequirements
if [ "$OS" == 'Linux' ]; then
    echo "sudo apt-get update"
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y git zsh vim
elif [ "$OS" == 'MINGW' ]; then
    echo "pacman update"
    pacman -S --needed zsh
fi

## prepare oh-my-zsh
if ! [ -d $ohmyzshDir ]; then
    echo 'Preparing oh-my-zsh dir'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

## link
echo "Making Symbolic Links:"
cd $dotfilesDir
for file in .??*; do
    echo "- $file"
    ln -sdf $dotfilesDir/$file $HOME/$file
done
