#!/bin/sh

set -x
set -e

## Rename Home Directory
LANG=C xdg-user-dirs-gtk-update

## Caps -> Ctrl
gsettings set org.gnome.libgnomekbd.keyboard options "['ctrl\tctrl:nocaps']"

## Packages
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean
sudo apt install -y git zsh curl vim

## dotfiles
$HOME/.dotfiles/install.sh

## VSCode
$HOME/.dotfiles/tools/install_vscode.sh

## TeX-Live
sudo apt install -y texlive-full
# error avoidance
rm -rf $HOME/.cpan
sudo cpan Log::Dispatch::File File::HomeDir

## Inkscape
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt-get update
sudo apt install -y inkscape
