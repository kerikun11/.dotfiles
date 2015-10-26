#!/bin/sh

echo "making .vimrc"
ln -sf ~/dotfiles/.vimrc ~/.vimrc

echo "installing NeoBundle"
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

