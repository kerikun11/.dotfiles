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

## oh-my-zsh directory
OHMYZSH_DIR="$HOME/.oh-my-zsh"

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
if [ ! -d $DOTFILES_DIR ]; then
    git clone $DOTFILES_REPOSITORY $DOTFILES_DIR
fi
echo "OK $DOTFILES_DIR"

##============================================================================##
## Zinit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
echo "OK Zinit"

##============================================================================##
## link dotfiles
cd $DOTFILES_LINK_DIR
dotfiles_link=$(find . -type f)
for file in ${dotfiles_link[@]}; do
    file=${file#./} # remove first "./"
    echo "  $file"
    mkdir -p $HOME/$(dirname $file)
    ln -sf $DOTFILES_LINK_DIR/$file $HOME/$file
done
echo "OK Symbolic Links"

##============================================================================##
## ending
echo "Everything has done. Enjoy!"
