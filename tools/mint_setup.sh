#!/bin/sh

set -x

## constants
dotfiles_dir="$HOME/.dotfiles"

## Rename Home Directory
LANG=C xdg-user-dirs-gtk-update

## Fcitx
patch -u $HOME/.config/fcitx/config < $dotfiles_dir/config/fcitx/config.patch

## Caps -> Ctrl
gsettings set org.gnome.libgnomekbd.keyboard options "['ctrl\tctrl:nocaps']"

## Packages
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean
sudo apt install -y git vim zsh cmake

## VSCode
## https://code.visualstudio.com/docs/setup/linux
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg /usr/share/keyrings/
rm /tmp/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y apt-transport-https
sudo apt install -y code
$dotfiles_dir/tools/nemo_init.sh

## TeX-Live
sudo apt install -y texlive-full
rm -r $HOME/.cpan
sudo cpan Log::Dispatch::File File::HomeDir
