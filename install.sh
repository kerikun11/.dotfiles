#!/bin/bash
##============================================================================##
## description  UNIX configuration files installer
## author       kerikun11
##============================================================================##
## exec option
# set -x # show command
set -e # first error to exit
set -u # undefined variable error

##============================================================================##
## definitions

## dotfiles
DOTFILES_REPOSITORY="https://github.com/kerikun11/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_LINK_DIR="$DOTFILES_DIR/dotfiles_link"

## Zinit directory
ZINIT_DIR="$HOME/.zinit"

##============================================================================##
## opening
echo '         __      __  _____ __         '
echo '    ____/ /___  / /_/ __(_) /__  _____'
echo '   / __  / __ \/ __/ /_/ / / _ \/ ___/'
echo ' _/ /_/ / /_/ / /_/ __/ / /  __(__  ) '
echo '(_)__,_/\____/\__/_/ /_/_/\___/____/  '
echo '                                      '

##============================================================================##
## required commands check
REQUIRED_COMMANDS=("git" "zsh" "curl")
for cmd in ${REQUIRED_COMMANDS[@]}; do
    if !(type $cmd >/dev/null 2>&1); then
        echo "install $cmd first!"
        exit 1
    fi
done
echo "OK ${REQUIRED_COMMANDS[@]}"

##============================================================================##
## clone .dotfiles if it does not exist
if [ -d $DOTFILES_DIR ]; then
    pushd $DOTFILES_DIR >/dev/null
    git pull
    popd >/dev/null
else
    git clone $DOTFILES_REPOSITORY $DOTFILES_DIR
fi
echo "OK $DOTFILES_DIR"

##============================================================================##
## link .dotfiles
pushd $DOTFILES_LINK_DIR >/dev/null
dotfiles_link=$(find . -type f)
for file in ${dotfiles_link[@]}; do
    file=${file#./} # remove first "./"
    echo "  $file"
    mkdir -p $HOME/$(dirname $file)
    ln -sf $DOTFILES_LINK_DIR/$file $HOME/$file
done
popd >/dev/null
echo "OK Symbolic Links"

##============================================================================##
## delete personal information
if [ $USER != "kerikun11" ]; then
    echo "unset git user config"
    git config --global --unset user.name
    git config --global --unset user.email
fi
echo "OK .gitconfig"

##============================================================================##
## Zinit
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
if [ -d $ZINIT_DIR/bin ]; then
    echo 'pulling Zinit'
    pushd $ZINIT_DIR/bin >/dev/null
    git pull
    popd >/dev/null
else
    echo 'installing Zinit'
    mkdir -p $ZINIT_DIR
    git clone https://github.com/zdharma/zinit.git $ZINIT_DIR/bin
fi
echo "OK Zinit"

##============================================================================##
## ending
echo "Everything has done. Enjoy!"
