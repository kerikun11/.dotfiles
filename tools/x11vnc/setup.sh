#!/bin/sh
set -eux

cd $(dirname $0)

# yay -S x11vnc
# sudo x11vnc -storepasswd /etc/.vncpasswd

sudo cp -v *.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable x11vnc-0 x11vnc-1 x11vnc-2
sudo systemctl start x11vnc-0 x11vnc-1 x11vnc-2
sudo systemctl status x11vnc-0 x11vnc-1 x11vnc-2
