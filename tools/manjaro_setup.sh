#!/bin/sh

# set -x # show command
set -e # first error to exit
set -u # unused variable error

## Rename Home Directory
LANG=C xdg-user-dirs-gtk-update

## Caps -> Ctrl
gsettings set org.gnome.libgnomekbd.keyboard options "['ctrl\tctrl:nocaps']"
echo "OK capslock"

## Cinnamon
gsettings set org.cinnamon.settings-daemon.peripherals.touchpad horizontal-scrolling true
gsettings set org.cinnamon.muffin placement-mode 'pointer'
gsettings set org.cinnamon.desktop.screensaver lock-enabled false
gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-ac-action 'nothing'
gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-battery-action 'nothing'
gsettings set org.cinnamon.settings-daemon.plugins.power idle-dim-time 30
gsettings set org.cinnamon.settings-daemon.plugins.power idle-brightness 5
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 3600               # sleep diplay
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-battery 300           # sleep diplay
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-battery-timeout 3600 # sleep PC
gsettings set org.cinnamon.settings-daemon.plugins.xsettings buttons-have-icons true         # theme -> misc
gsettings set org.cinnamon.settings-daemon.plugins.xsettings menus-have-icons true           # theme -> misc
echo "OK Cinnamon"

## Nemo
gsettings set org.nemo.desktop show-desktop-icons false
gsettings set org.nemo.preferences default-folder-viewer 'list-view'
gsettings set org.nemo.window-state start-with-menu-bar false
## tool bar
gsettings set org.nemo.preferences show-compact-view-icon-toolbar true
gsettings set org.nemo.preferences show-open-in-terminal-toolbar true
gsettings set org.nemo.preferences show-home-icon-toolbar true
gsettings set org.nemo.preferences show-new-folder-icon-toolbar true
gsettings set org.nemo.preferences show-edit-icon-toolbar true
gsettings set org.nemo.preferences show-computer-icon-toolbar true
echo "OK nemo"

## Package Source Repository
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
$yay_install_cmd base-devel
## dev
$yay_install_cmd gcc gcc-multilib cmake valgrind kcachegrind
$yay_install_cmd arduino code inkscape
$yay_install_cmd kicad kicad-library kicad-library-3d
$yay_install_cmd qtcreator qt5-base
## utility
$yay_install_cmd trash-cli xclip figlet sl hugo asciidoctor doxygen graphviz
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
$yay_install_cmd mint-themes
$yay_install_cmd vimix-gtk-themes vimix-icon-theme
echo "OK packages"

## Fcitx and Mozc
$yay_install_cmd fcitx-mozc fcitx-im fcitx-configtool
echo "OK Mozc"

## ending
echo "Everything has done."
figlet -f big Enjoy!
echo "Please Reboot to apply the configrations"
