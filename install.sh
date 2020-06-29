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
    if ! type $cmd >/dev/null 2>&1; then
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
## oh-my-zsh
if [ ! -d $OHMYZSH_DIR ]; then
    echo 'installing oh-my-zsh'
    echo exit | sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
echo "OK oh-my-zsh"

## Zsh Powerlevel10k theme
## see https://github.com/romkatv/powerlevel10k#oh-my-zsh
ZSH_THEME_P10K_DIR=$OHMYZSH_DIR/custom/themes/powerlevel10k
if [ ! -d $ZSH_THEME_P10K_DIR ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_THEME_P10K_DIR
fi
echo "OK zsh Powerlevel10k theme"

## Fast Syntax Highlighting (F-Sy-H)
## see https://github.com/zdharma/fast-syntax-highlighting
ZSH_CUSTOM=$OHMYZSH_DIR/custom
ZSH_SYNTAX_HIGHLIGHTING=$ZSH_CUSTOM/plugins/fast-syntax-highlighting
if [ ! -d $ZSH_SYNTAX_HIGHLIGHTING ]; then
    echo 'installing zsh syntax highlighting'
    git clone https://github.com/zdharma/fast-syntax-highlighting $ZSH_SYNTAX_HIGHLIGHTING
fi
echo "OK zsh syntax highlighting"

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
if [ $(whoami) != "kerikun11" ]; then
    echo "unset git user config"
    git config --global --unset user.name
    git config --global --unset user.email
fi
echo "OK .gitconfig"

##============================================================================##
## ending
echo "Everything has done. Enjoy!"
