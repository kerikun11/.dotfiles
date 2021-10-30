#!/bin/sh -eux

## https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
sh -c "$(curl -fsSL https://get.docker.com)"

## start
sudo service docker enable
sudo service docker start

## group
sudo gpasswd -a $USER docker
newgrp docker
