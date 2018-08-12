#!/bin/bash

## setup the ESP-IDF environment
## for details, see http://esp-idf.readthedocs.io/en/latest/get-started/linux-setup.html
## this is only for Linux Ubuntu
## this script makes a directory '~/Application/Espressif' and install toolchain and esp-idf there
## and configures PATH and IDF_PATH to .zprofile (zsh) and .profile (bash)

## error by undefined variable
set -u

## please update to a latest one
toolchain_filename='xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz'

## settings
idf_dir_from_home="Application/Espressif"
idf_dir="$HOME/$idf_dir_from_home"
toolchain_name='xtensa-esp32-elf'
esp_idf_url='https://github.com/espressif/esp-idf'
profiles=("$HOME/.zprofile" "$HOME/.profile")

## install software
echo "sudo apt-get update"
#sudo apt-get update
sudo apt-get install -y gcc git wget make libncurses-dev flex bison gperf python python-serial

## make Espressif directory
echo mkdir "\$HOME/$idf_dir_from_home"
mkdir -p $idf_dir
cd $idf_dir
if [ ! -e $toolchain_filename ] || [ ! -d $toolchain_name ]; then 
	wget --no-clobber "https://dl.espressif.com/dl/$toolchain_filename"
	tar -xzvf $toolchain_filename
fi

## get esp-idf
if [ -d "$idf_dir/esp-idf" ]; then
	echo "update esp-idf"
	cd $idf_dir/esp-idf
	git clean -dxf
	git pull -f
	git submodule update --init --recursive
else
	echo "clone esp-idf"
	git clone --recursive $esp_idf_url
fi

## add me to dialout group
sudo gpasswd -a $USER dialout

## environmental variable
echo "add enviroment variable"
export_paths=(
	"export PATH=\$PATH:\$HOME/$idf_dir_from_home/xtensa-esp32-elf/bin"
	"export IDF_PATH=\$HOME/$idf_dir_from_home/esp-idf"
)
# deal with an array which has some spaces
IFS_bak=$IFS
IFS=$'\n'
for export_path in ${export_paths[@]}; do
	echo $export_path
	for profile in ${profiles[@]}; do
		if ! grep -q $export_path $profile; then
			echo $export_path >> $profile
		fi
	done
done
IFS=$IFS_bak

## complete
echo "setup complete"
echo "please reopen the shell to reflect PATH"

