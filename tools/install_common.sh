#!/bin/sh

## packages
packages="git wget curl vim bash zsh"

## sudo necessity
[ type sudo ] >/dev/null 2>&1 && SUDO=sudo || SUDO=

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
    $SUDO pacman -g
    $SUDO pacman -Syy --noconfirm
    $SUDO pacman -S --noconfirm $packages
fi
