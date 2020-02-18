#!/bin/sh

set -x
set -e

## see https://code.visualstudio.com/docs/setup/linux
wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >/tmp/packages.microsoft.gpg
sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg /usr/share/keyrings/
rm /tmp/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y apt-transport-https
sudo apt install -y code

# vscode icon
sudo mkdir -p /usr/local/share/icons
sudo ln -sf "/usr/share/code/resources/app/resources/linux/code.png" "/usr/local/share/icons/code.png"
