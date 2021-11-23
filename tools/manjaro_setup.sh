#!/bin/sh
## Manjaro Cinnamon Setup Script
## Copyright 2021 Ryotaro Onuki <kerikun11+github@gmail.com>

set -x # show command
set -e # first error to exit
set -u # unused variable error

## Rename Home Directory
LANG=C xdg-user-dirs-gtk-update

## avoid sudo timeout
sudo -v
while :; do
    sudo -v
    sleep 59
done &
sudo_process=$!

## NTP
sudo timedatectl set-ntp true
echo "OK NTP"

## Caps -> Ctrl
gsettings set org.gnome.libgnomekbd.keyboard model pc105
gsettings set org.gnome.libgnomekbd.keyboard layouts "['us']"
gsettings set org.gnome.libgnomekbd.keyboard options "['ctrl\tctrl:nocaps']"
echo "OK Caps -> Ctrl"

## Cinnamon
$HOME/.dotfiles/tools/cinnamon_setup.sh
echo "OK Cinnamon Settings"

## Manjaro Mirror Lists
sudo pacman-mirrors -c Japan
echo "OK Manjaro Mirror List"

## Packages
sudo pacman -Syuu --noconfirm --needed --quiet
## Arch User Repository
sudo pacman -S --noconfirm --needed yay
yay_install_cmd="yay -S --noconfirm --quiet --needed --needed"
## requirements
$yay_install_cmd base-devel # for yay build and install
$yay_install_cmd git zsh tmux
$yay_install_cmd gvim trash-cli xsel figlet sl tldr jq pv fzf
## dev
$yay_install_cmd gcc-multilib cmake ninja gdb docker
# $yay_install_cmd valgrind kcachegrind
# $yay_install_cmd qtcreator qt5-base
# $yay_install_cmd qemu-user-static
# $yay_install_cmd kicad kicad-library kicad-library-3d
$yay_install_cmd hugo asciidoctor doxygen graphviz
$yay_install_cmd dos2unix perl-image-exiftool
$yay_install_cmd xorg-xinput bluez-utils zsa-wally-bin
## Desktop Applications
$yay_install_cmd visual-studio-code-bin
$yay_install_cmd google-chrome
# $yay_install_cmd inkscape
# $yay_install_cmd discord
# $yay_install_cmd slack-desktop
# $yay_install_cmd dropbox nemo-dropbox
# $yay_install_cmd wps-office
echo "OK packages"

## Fonts
$yay_install_cmd otf-ipafont
gsettings set org.cinnamon.desktop.interface font-name 'IPA Pゴシック 10'
gsettings set org.cinnamon.desktop.wm.preferences titlebar-font 'IPA Pゴシック 10'
gsettings set org.gnome.desktop.interface document-font-name 'IPA P明朝 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'IPAゴシック 10'
gsettings set org.nemo.desktop font 'IPA Pゴシック 10'
echo "OK Fonts"

## Theme
$yay_install_cmd vimix-gtk-themes vimix-icon-theme
gsettings set org.cinnamon.desktop.interface gtk-theme 'vimix-dark-laptop-doder'
gsettings set org.cinnamon.desktop.wm.preferences theme 'vimix-dark-laptop-doder'
gsettings set org.cinnamon.theme name 'vimix-dark-laptop-doder'
gsettings set org.cinnamon.desktop.interface icon-theme 'Vimix-Doder-dark'
echo "OK Theme"

## Fcitx and Mozc
$yay_install_cmd fcitx-mozc fcitx-im fcitx-configtool
echo "OK Mozc"

## Ending
echo "Everything has done."
figlet -f big Enjoy!
echo "Please Reboot to apply the configurations"

## cleaning of avoid sudo timeout
kill "$sudo_process"
