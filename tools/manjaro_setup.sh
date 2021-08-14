#!/bin/sh

# set -x # show command
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
infiloop=$!

## NTP
sudo timedatectl set-ntp true

## Caps -> Ctrl
gsettings set org.gnome.libgnomekbd.keyboard model pc105
gsettings set org.gnome.libgnomekbd.keyboard layouts "['jp']"
gsettings set org.gnome.libgnomekbd.keyboard options "['ctrl\tctrl:nocaps']"
echo "OK Caps -> Ctrl"

## Cinnamon
$HOME/.dotfiles/tools/cinnamon_setup.sh
echo "OK Cinnamon Settings"

## Package Source Repository
sudo cp $HOME/.dotfiles/tools/manjaro/mirrorlist /etc/pacman.d/mirrorlist

## Packages
sudo pacman -Syuu --noconfirm --needed --quiet
## Arch User Repository
sudo pacman -S --noconfirm --needed yay
yay_install_cmd="yay -S --noconfirm --quiet --needed --needed"
## requirements
$yay_install_cmd git zsh curl gvim
$yay_install_cmd base-devel
## dev
$yay_install_cmd gcc gcc-multilib gdb cmake valgrind kcachegrind
$yay_install_cmd visual-studio-code-bin inkscape
$yay_install_cmd kicad kicad-library kicad-library-3d
$yay_install_cmd qtcreator qt5-base
## utility
$yay_install_cmd trash-cli xsel figlet sl exa bat fd tldr peco ghq jq
$yay_install_cmd hugo asciidoctor doxygen graphviz
$yay_install_cmd dos2unix perl-image-exiftool
## font
$yay_install_cmd otf-ipafont ttf-ubuntu-font-family
## Google Chrome
$yay_install_cmd google-chrome
## slack
$yay_install_cmd slack-desktop
## Dropbox
$yay_install_cmd dropbox
$yay_install_cmd nemo-dropbox
## WPS Office
# $yay_install_cmd wps-office
## Theme
# $yay_install_cmd mint-themes
$yay_install_cmd vimix-gtk-themes vimix-icon-theme
echo "OK packages"

## Fcitx and Mozc
$yay_install_cmd fcitx-mozc fcitx-im fcitx-configtool
echo "OK Mozc"

## ending
echo "Everything has done."
figlet -f big Enjoy!
echo "Please Reboot to apply the configurations"

## cleaning of avoid sudo timeout
kill "$infiloop"
