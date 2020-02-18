#!/bin/sh

set -x

sudo apt update
sudo apt upgrade -y
sudo apt install -y docker.io cgroupfs-mount
sudo cgroupfs-mount
sudo gpasswd -a $USER docker
sudo service docker start
