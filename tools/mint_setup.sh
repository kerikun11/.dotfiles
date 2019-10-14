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
## https://code.visualstudio.com/docs/setup/linux
wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >/tmp/packages.microsoft.gpg
sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg /usr/share/keyrings/
rm /tmp/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y apt-transport-https
sudo apt install -y code
# vscode icon
sudo mkdir -p /usr/local/share/icons
sudo ln -sf "/usr/share/code/resources/app/resources/linux/code.png" "/usr/local/share/icons/code.png"

## TeX-Live
sudo apt install -y texlive-full
rm -rf $HOME/.cpan
sudo cpan Log::Dispatch::File File::HomeDir
