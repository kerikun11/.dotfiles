#!/bin/sh
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
REQUIRED_COMMANDS="curl git zsh"
if ! type $REQUIRED_COMMANDS >/dev/null 2>&1; then
    ## sudo detection
    type sudo >/dev/null 2>&1 && [ "$(whoami)" != "root" ] && SUDO="sudo" || SUDO=""
    ## install required packages using an existing package manager
    if type apt-get >/dev/null 2>&1; then # ubuntu, debian
        $SUDO apt-get update
        $SUDO apt-get install -yq $REQUIRED_COMMANDS
    elif type pacman >/dev/null 2>&1; then # arch, manjaro, MSYS2
        $SUDO pacman -Sy --quiet --noconfirm --needed $REQUIRED_COMMANDS
    elif type apk >/dev/null 2>&1; then # alpine
        $SUDO apk add $REQUIRED_COMMANDS
    elif type yum >/dev/null 2>&1; then # centos
        $SUDO yum install -yq $REQUIRED_COMMANDS
    else # can't detect package manager
        echo "Error. install $REQUIRED_COMMANDS first!"
        exit -1
    fi
fi
echo "OK $REQUIRED_COMMANDS"

##============================================================================##
## clone .dotfiles if it does not exist
if [ ! -d $DOTFILES_DIR ]; then
    git clone $DOTFILES_REPOSITORY $DOTFILES_DIR
else
    git -C $DOTFILES_DIR pull
fi
echo "OK $DOTFILES_DIR"

##============================================================================##
## oh-my-zsh
if [ ! -d $OHMYZSH_DIR ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $OHMYZSH_DIR
else
    git -C $OHMYZSH_DIR pull
fi
echo "OK oh-my-zsh"

## Zsh Powerlevel10k theme
## see https://github.com/romkatv/powerlevel10k#oh-my-zsh
ZSH_THEME_P10K_DIR=$OHMYZSH_DIR/custom/themes/powerlevel10k
if [ ! -d $ZSH_THEME_P10K_DIR ]; then
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_THEME_P10K_DIR
else
    git -C $ZSH_THEME_P10K_DIR pull
fi
echo "OK zsh Powerlevel10k theme"

## Fast Syntax Highlighting (F-Sy-H)
## see https://github.com/zdharma/fast-syntax-highlighting
ZSH_SYNTAX_HIGHLIGHTING=$OHMYZSH_DIR/custom/plugins/fast-syntax-highlighting
if [ ! -d $ZSH_SYNTAX_HIGHLIGHTING ]; then
    git clone https://github.com/zdharma/fast-syntax-highlighting \
        $ZSH_SYNTAX_HIGHLIGHTING
else
    git -C $ZSH_SYNTAX_HIGHLIGHTING pull
fi
echo "OK zsh syntax highlighting"

## zsh-vi-mode plugin
ZSH_VI_MODE_DIR=$OHMYZSH_DIR/custom/plugins/zsh-vi-mode
if [ ! -d $ZSH_VI_MODE_DIR ]; then
    git clone https://github.com/jeffreytse/zsh-vi-mode.git $ZSH_VI_MODE_DIR
else
    git -C $ZSH_VI_MODE_DIR pull
fi
echo "OK zsh vi mode"

##============================================================================##
## link .dotfiles
DOTFILES_LINK_DIR="$DOTFILES_DIR/dotfiles_link"
dotfiles_link=$(find $DOTFILES_LINK_DIR -type f)
for link_target in $dotfiles_link; do
    # make link_name
    file=${link_target#$DOTFILES_LINK_DIR/} # remove first path
    link_name="$HOME/$file"
    echo "link: $file"
    # If there is a file that is not a symbolic link, back it up.
    if [ -f $link_name ] && [ ! -L $link_name ]; then
        echo "  $file -> $file.backup"
        mv $link_name $link_name.backup
    fi
    # make a symbolic link
    mkdir -p $(dirname $link_name)
    ln -sf $link_target $link_name
done
echo "OK Symbolic Links"

##============================================================================##
## delete personal information
if [ $(whoami) != "$DEFAULT_USER" ]; then
    echo "  unset git user config"
    git config --global --get user.name 2>&1 >/dev/null &&
        git config --global --unset user.name
    git config --global --get user.email 2>&1 >/dev/null &&
        git config --global --unset user.email
fi
echo "OK .gitconfig"

##============================================================================##
## change default shell to zsh
if [ -f /etc/passwd ] &&
    [ $(grep $(whoami) </etc/passwd | cut -f 7 -d ":") != $(which zsh) ]; then
    read -p "Do you want to change default shell to zsh? [Y/n] :" YN
    case "$YN" in "Y" | "y" | "")
        chsh -s $(which zsh)
        echo "OK chsh to zsh"
        ;;
    esac
fi

##============================================================================##
## ending
echo "Everything has done. Enjoy!"

##============================================================================##
## start (or reload) zsh
exec $(which zsh) -l
