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
    pushd $DOTFILES_DIR
    git pull
    popd
else
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
## delete personal information
if [ $USER != "kerikun11" ]; then
    git config --global --unset user.name
    git config --global --unset user.email
fi

##============================================================================##
## ending
echo "Everything has done. Enjoy!"
