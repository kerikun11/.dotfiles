#!/bin/sh

echo "linking .vimrc"
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
echo "OK\n"

echo "linking .zshrc"
ln -sf ~/dotfiles/.zshrc ~/.zshrc
echo "OK\n"

echo "installing NeoBundle"
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
echo "OK\n"

