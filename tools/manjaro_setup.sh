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
## dev
$yay_install_cmd gcc gcc-multilib cmake valgrind kcachegrind
$yay_install_cmd arduino code inkscape kicad
$yay_install_cmd base-devel
$yay_install_cmd qtcreator qt5-base
## utility
$yay_install_cmd trash-cli figlet sl hugo asciidoctor doxygen
$yay_install_cmd dos2unix
## font
$yay_install_cmd otf-ipafont
## WPS Office
$yay_install_cmd wps-office
## Google Chrome
$yay_install_cmd google-chrome
## slack
$yay_install_cmd slack-desktop
## Dropbox
$yay_install_cmd dropbox
$yay_install_cmd nemo-dropbox
echo "OK packages"

## Theme
$yay_install_cmd mint-themes
$yay_install_cmd vimix-gtk-themes vimix-icon-theme

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
