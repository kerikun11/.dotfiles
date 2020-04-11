#!/bin/sh

# set -x # show command
set -e # first error to exit
set -u # unused variable error

## Rename Home Directory
LANG=C xdg-user-dirs-gtk-update

## Caps -> Ctrl
gsettings set org.gnome.libgnomekbd.keyboard options "['ctrl\tctrl:nocaps']"
echo "OK capslock"

## hide desktop entry
# gsettings set org.nemo.desktop show-desktop-icons false

## Package Source Repository
## see https://wiki.manjaro.org/index.php?title=Pacman-mirrors%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AB%E3%82%88%E3%82%8B%E3%83%9F%E3%83%A9%E3%83%BC%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%83%AA%E3%82%B9%E3%83%88%E3%81%AE%E6%9B%B4%E6%96%B0
read -p "update pacman mirrors? [y/N] :" YN
case "$YN" in "Y" | "y")
    sudo pacman-mirrors --fasttrack && sudo pacman -Syy
    echo "OK pacman mirrors"
    ;;
esac

## Packages
sudo pacman -Syuu --noconfirm --needed --quiet
## Arch User Repository
sudo pacman -S --noconfirm --needed yay
yay_install_cmd="yay -S --noconfirm --quiet --needed --needed"
## requirements
$yay_install_cmd git zsh curl vim
## dev
$yay_install_cmd gcc gcc-multilib cmake valgrind kcachegrind
$yay_install_cmd arduino code inkscape kicad
$yay_install_cmd base-devel
## utility
$yay_install_cmd trash-cli figlet sl hugo asciidoctor doxygen
## font
$yay_install_cmd otf-ipafont
## WPS Office
$yay_install_cmd wps-office
## Google Chrome
$yay_install_cmd google-chrome
## slack
$yay_install_cmd slack-desktop
## Dropbox
$yay_install_cmd dropbox nemo-dropbox
echo "OK packages"

## Fcitx and Mozc
$yay_install_cmd fcitx-mozc fcitx-im
fcitx-autostart
echo "OK mozc"

## Change Shell
myshell="/usr/bin/zsh"
if [ $SHELL != $myshell ]; then
    chsh -s /usr/bin/zsh
    echo "OK Change Shell to Zsh"
fi

## ending
echo "Everything has done."
figlet -f big Enjoy!
echo "Please Reboot to apply the configrations"
