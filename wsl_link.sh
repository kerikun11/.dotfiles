#!/bin/bash -x

link_dirs=("Documents" "Downloads" "OneDrive" "Dropbox")

## determine OS
if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	OS='Linux'
	windows_home_dir="/c/Users/$USER"
elif [ "$(expr substr $(uname -s) 1 5)" == 'MINGW' ]; then
	OS='MINGW32'
	windows_home_dir="/c/Users/$USER"
else
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi
echo "OS: $OS"

for d in ${link_dirs[@]}; do
	echo Link: $d
	ln -sf "$windows_home_dir/$d" "$HOME/"
done
