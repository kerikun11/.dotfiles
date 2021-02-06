#!/bin/bash
##============================================================================##
## description  UNIX configuration files installer
## author       kerikun11
##============================================================================##
## exec option
set -e # first error to exit

##============================================================================##
## definitions
# .dotfiles
DOTFILES_REPOSITORY="https://github.com/kerikun11/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_LINK_DIR="$DOTFILES_DIR/dotfiles_link"
# Oh My Zsh
OHMYZSH_DIR="$HOME/.oh-my-zsh"
# my user name
DEFAULT_USER="kerikun11"

##============================================================================##
## opening
echo '         __      __  _____ __         '
echo '    ____/ /___  / /_/ __(_) /__  _____'
echo '   / __  / __ \/ __/ /_/ / / _ \/ ___/'
echo ' _/ /_/ / /_/ / /_/ __/ / /  __(__  ) '
echo '(_)__,_/\____/\__/_/ /_/_/\___/____/  '
echo '                                      '

##============================================================================##
## required commands install
REQUIRED_COMMANDS="curl zsh git"
if ! type $REQUIRED_COMMANDS >/dev/null 2>&1; then
    ## sudo detect
    type sudo >/dev/null 2>&1 && [ "$(whoami)" != "root" ] && SUDO="sudo" || SUDO=""
    ## install according to the OS
    if type apt >/dev/null 2>&1; then
        $SUDO apt update
        $SUDO apt install -yq $REQUIRED_COMMANDS
    elif type pacman >/dev/null 2>&1; then
        $SUDO pacman -Sy --quiet
        $SUDO pacman -S --quiet --noconfirm --needed $REQUIRED_COMMANDS
    elif type apk >/dev/null 2>&1; then
        $SUDO apk add $REQUIRED_COMMANDS
    elif type yum >/dev/null 2>&1; then
        $SUDO yum install -yq $REQUIRED_COMMANDS
    else
        echo "NG $REQUIRED_COMMANDS"
        exit -1
    fi
fi
echo "OK $REQUIRED_COMMANDS"

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
## oh-my-zsh
if [ ! -d $OHMYZSH_DIR ]; then
    echo 'installing oh-my-zsh'
    echo exit | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
echo "OK oh-my-zsh"

## Zsh Powerlevel10k theme
## see https://github.com/romkatv/powerlevel10k#oh-my-zsh
ZSH_THEME_P10K_DIR=$OHMYZSH_DIR/custom/themes/powerlevel10k
if [ ! -d $ZSH_THEME_P10K_DIR ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        $ZSH_THEME_P10K_DIR
fi
echo "OK zsh Powerlevel10k theme"

## Fast Syntax Highlighting (F-Sy-H)
## see https://github.com/zdharma/fast-syntax-highlighting
ZSH_CUSTOM=$OHMYZSH_DIR/custom
ZSH_SYNTAX_HIGHLIGHTING=$ZSH_CUSTOM/plugins/fast-syntax-highlighting
if [ ! -d $ZSH_SYNTAX_HIGHLIGHTING ]; then
    echo 'installing zsh syntax highlighting'
    git clone https://github.com/zdharma/fast-syntax-highlighting \
        $ZSH_SYNTAX_HIGHLIGHTING
fi
echo "OK zsh syntax highlighting"

##============================================================================##
## link .dotfiles
pushd $DOTFILES_LINK_DIR >/dev/null
dotfiles_link=$(find . -type f)
for file in ${dotfiles_link[@]}; do
    file=${file#./} # remove first "./"
    echo "  $file"
    link_from="$DOTFILES_LINK_DIR/$file"
    link_to="$HOME/$file"
    # If there is a file that is not a symbolic link, back it up.
    if [ -f $link_to ] && [ ! -L $link_to ]; then
        echo "  $file -> $file.backup"
        mv $link_to $link_to.backup
    fi
    # make a symbolic link
    mkdir -p $(dirname $link_to)
    ln -sf $link_from $link_to
done
popd >/dev/null
echo "OK Symbolic Links"

##============================================================================##
## delete personal information
if [ $(whoami) != "$DEFAULT_USER" ]; then
    echo "unset git user config"
    git config --global --unset user.name
    git config --global --unset user.email
fi
echo "OK .gitconfig"

##============================================================================##
## ending
echo "Everything has done. Enjoy!"
