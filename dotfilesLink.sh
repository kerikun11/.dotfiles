#!/bin/sh

echo "making .vimrc"
ln -sf ~/dotfiles/.vimrc ~/.vimrc

echo "making .zshrc"
ln -sf ~/dotfiles/.zshrc ~/.zshrc

echo "installing NeoBundle"
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

