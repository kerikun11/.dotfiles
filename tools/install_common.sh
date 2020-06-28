#!/bin/sh

## packages
packages="git wget curl vim bash zsh"

## sudo necessity
if [ "$(whoami)" == "root" ]; then
    SUDO=
elif type sudo >/dev/null 2>&1; then
    SUDO=sudo
else
    SUDO=
fi

## install according to the OS
if type apt >/dev/null 2>&1; then
    # apt
    $SUDO apt update
    $SUDO apt install -y $packages
elif type apk >/dev/null 2>&1; then
    # apk
    $SUDO apk add $packages
elif type yum >/dev/null 2>&1; then
    # yum
    $SUDO yum add $packages
elif type pacman >/dev/null 2>&1; then
    # pacman
    $SUDO pacman -Syy --noconfirm --needed
    $SUDO pacman -S --noconfirm --needed $packages
fi
