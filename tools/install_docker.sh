#!/bin/sh

set -x

sudo apt update
sudo apt upgrade -y
sudo apt install -y docker.io
sudo cgroupfs-mount
sudo usermod -aG docker $USER
sudo service docker start
