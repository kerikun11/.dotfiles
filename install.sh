#!/bin/bash
## file:    dotfiles installer
## author:  kerikun11

## option
# set -x # show command
set -e # first error to exit
set -u # unused variable error

# dotfiles
DOTFILES_GITHUB="https://github.com/kerikun11/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_AUTO_DIR="$DOTFILES_DIR/dotfiles_auto"

# oh-my-zsh
OHMYZSH_DIR="$HOME/.oh-my-zsh"

## opening
echo '      _       _    __ _ _           '
echo '   __| | ___ | |_ / _(_) | ___  ___ '
echo '  / _` |/ _ \| __| |_| | |/ _ \/ __|'
echo ' | (_| | (_) | |_|  _| | |  __/\__ \'
echo '(_)__,_|\___/ \__|_| |_|_|\___||___/'
echo ''

## requred commands
REQUIRED_COMMANDS=("git" "zsh" "wget")
for cmd in ${REQUIRED_COMMANDS[@]}; do
    if !(type $cmd >/dev/null 2>&1); then
        echo "install $cmd first!"
        exit 1
    fi
done
echo "OK ${REQUIRED_COMMANDS[@]}"

## clone .dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone $DOTFILES_GITHUB $DOTFILES_DIR
fi
echo "OK $DOTFILES_DIR"

## oh-my-zsh
if [ ! -d $OHMYZSH_DIR ]; then
    echo 'installing oh-my-zsh'
    echo exit | sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
touch $HOME/.zshenv >/dev/null
echo "OK oh-my-zsh"

## link dotfiles
cd $DOTFILES_AUTO_DIR
dotfiles_auto=$(find . -type f)
for file in ${dotfiles_auto[@]}; do
    file=${file#./} # remove first "./"
    echo "  $file"
    mkdir -p $HOME/$(dirname $file)
    ln -sf $DOTFILES_AUTO_DIR/$file $HOME/$file
done
echo "OK Symbolic Links"

## Ending
echo "Everything has done. Enjoy!"

