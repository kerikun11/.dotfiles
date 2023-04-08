#!/bin/sh
##============================================================================##
## UNIX configuration files installer
## Copyright (c) 2021 Ryotaro Onuki <kerikun11+github@gmail.com>
##============================================================================##
## exec option
set -e # first error to exit
set -u # referencing undefined variables as an error

##============================================================================##
## definitions
DOTFILES_REPOSITORY="https://github.com/kerikun11/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_LINK_DIR="$DOTFILES_DIR/dotfiles_link"
DEFAULT_USER="kerikun11"

##============================================================================##
## opening
echo "
         __      __  _____ __         
    ____/ /___  / /_/ __(_) /__  _____
   / __  / __ \/ __/ /_/ / / _ \/ ___/
 _/ /_/ / /_/ / /_/ __/ / /  __(__  ) 
(_)__,_/\____/\__/_/ /_/_/\___/____/  
                                      
"

##============================================================================##
## install required commands
REQUIRED_COMMANDS="curl git zsh"
if ! type $REQUIRED_COMMANDS 2>&1 >/dev/null; then
    ## sudo detection
    type sudo 2>&1 >/dev/null && [ "$(whoami)" != "root" ] && SUDO="sudo" || SUDO=""
    ## install required packages using an existing package manager
    if type apt-get 2>&1 >/dev/null; then # ubuntu, debian
        $SUDO apt-get -qq update
        $SUDO apt-get -qq install -yqq $REQUIRED_COMMANDS
    elif type pacman 2>&1 >/dev/null; then # arch, manjaro, MSYS2
        $SUDO pacman -Sy --quiet --noconfirm --needed $REQUIRED_COMMANDS
    elif type apk 2>&1 >/dev/null; then # alpine
        $SUDO apk add $REQUIRED_COMMANDS
    elif type yum 2>&1 >/dev/null; then # centos
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
## link .dotfiles
dotfiles_link_files=$(find $DOTFILES_LINK_DIR -type f)
for link_target in $dotfiles_link_files; do
    ## make link_name
    file=${link_target#$DOTFILES_LINK_DIR/} # remove first path
    link_name=$HOME/$file
    echo "  link: $file"
    ## If there is a file that is not a symbolic link, back it up.
    if [ -f $link_name ] && [ ! -L $link_name ]; then
        file_backup=$file.backup-$(date +%Y%m%d-%H%M%S)
        echo "        $file -> $file_backup"
        mv $HOME/$file $HOME/$file_backup
    fi
    ## make a symbolic link
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
    echo "OK unset user in .gitconfig"
fi

##============================================================================##
## change default shell to zsh
if [ -f /etc/passwd ] && ! grep -e "$(whoami).*zsh" /etc/passwd 2>&1 >/dev/null; then
    read -p "Do you want to change default shell to zsh? [Y/n] :" YN
    case "$YN" in "Y" | "y" | "")
        chsh -s $(which zsh)
        echo "OK change default shell to zsh"
        ;;
    esac
fi

##============================================================================##
## ending
echo "Everything has done."
echo '
    ______        _             __
   / ____/___    (_)___  __  __/ /
  / __/ / __ \  / / __ \/ / / / / 
 / /___/ / / / / / /_/ / /_/ /_/  
/_____/_/ /_/_/ /\____/\__, (_)   
           /___/      /____/      
'

##============================================================================##
## start (or reload) zsh
exec $(which zsh) -l
