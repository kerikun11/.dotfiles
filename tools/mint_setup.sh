#!/bin/sh
## Linux Mint Cinnamon Setup Script
## Copyright 2021 Ryotaro Onuki <kerikun11+github@gmail.com>

# set -x # show command
set -e # first error to exit
set -u # unused variable error

## Rename Home Directory
LANG=C xdg-user-dirs-gtk-update

## Caps -> Ctrl
gsettings set org.gnome.libgnomekbd.keyboard options "['ctrl\tctrl:nocaps']"
echo "OK capslock"

## hide desktop entry
gsettings set org.nemo.desktop show-desktop-icons false

## Package Source Repository
read -p "open software source settings? [y/N] :" YN
case "$YN" in "Y" | "y")
    sudo pkexec mintsources
    ;;
esac
echo "OK software source"

## Packages
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean
sudo apt install -y git zsh curl vim

## dev
sudo apt install -y gcc g++ gcc-multilib cmake valgrind kcachegrind
## utility
sudo apt install -y trash-cli figlet
echo "OK packages"

## dotfiles
$HOME/.dotfiles/install.sh
echo "OK .dotfiles"

## Cinnamon
$HOME/.dotfiles/tools/cinnamon_setup.sh
echo "OK Cinnamon"

## VSCode
$HOME/.dotfiles/tools/install_vscode.sh
echo "OK VSCode"

## ending
echo "Everything has done. Enjoy!"
