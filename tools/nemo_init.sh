#!/bin/sh

# vscode here in nemo
cp $HOME/.dotfiles/config/nemo/actions/vscode.nemo_action \
   $HOME/.local/share/nemo/actions/vscode.nemo_action

# vscode icon
sudo mkdir -p /usr/local/share/icons
sudo ln -sf "/usr/share/code/resources/app/resources/linux/code.png" "/usr/local/share/icons/code.png"
