#!/bin/bash -x

link_dirs=("Documents" "Downloads" "OneDrive" "Dropbox")
windows_home_dir="/c/Users/$USER"

for d in ${link_dirs[@]}; do
	echo Link: $d
	ln -sf "$windows_home_dir/$d" "$HOME/"
done
