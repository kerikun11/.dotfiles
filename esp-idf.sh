#!/bin/sh

# see http://esp-idf.readthedocs.io/en/latest/get-started/linux-setup.html

# settings
idf_dir_from_home="Application/Espressif"
idf_dir="$HOME/$idf_dir_from_home"
toolchain_filename='xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz'

# install software
sudo apt-get install gcc git wget make libncurses-dev flex bison gperf python python-serial

# make Espressif directory
mkdir -p $idf_dir
cd $idf_dir
wget --no-clobber "https://dl.espressif.com/dl/$toolchain_filename"
tar -xzvf $toolchain_filename

# get esp-idf
if [ -d "$idf_dir/esp-idf" ]; then
	cd $idf_dir/esp-idf
	git clean -dxf
	git pull -f
	git submodule update --init --recursive --force
else
	git clone --recursive 
fi

# add me to dialout group
sudo gpasswd -a $USER dialout

# environmental variable
echo "=== add enviroment variable ==="
echo "export PATH=\$PATH:\$HOME/$idf_dir_from_home/xtensa-esp32-elf/bin"
echo "export IDF_PATH=\$HOME/$idf_dir_from_home/esp-idf"
echo "==============================="

