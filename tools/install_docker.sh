#!/bin/sh

set -x
set -e

# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
curl -fsSL https://get.docker.com | sh
sudo gpasswd -a $USER docker
sudo service docker start
