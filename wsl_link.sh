#!/bin/bash

link_dirs=("Documents" "Downloads" "OneDrive" "Dropbox")
windows_home_dir="/mnt/c/Users/$USER"

for d in ${link_dirs[@]}; do
	echo Link: $d
	ln -sdf "$windows_home_dir/$d" "$HOME/$d"
done
