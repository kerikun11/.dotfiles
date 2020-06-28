# .dotfiles @ kerikun11

My Configuration Files for UNIX Systems

```
         __      __  _____ __         
    ____/ /___  / /_/ __(_) /__  _____
   / __  / __ \/ __/ /_/ / / _ \/ ___/
 _/ /_/ / /_/ / /_/ __/ / /  __(__  ) 
(_)__,_/\____/\__/_/ /_/_/\___/____/  
                                      
```

> Note that .gitconfig contains my personal information.
> Don't install it as is, except for me!

## install .dotfiles @ kerikun11

```sh
curl -fsSL https://raw.githubusercontent.com/kerikun11/.dotfiles/master/install.sh | bash
```

## configure automatically

```sh
## install common packages
curl -fsSL https://raw.githubusercontent.com/kerikun11/.dotfiles/master/tools/install_common.sh | sh
# Manjaro Linux Cinnamon 19.2
curl -fsSL https://raw.githubusercontent.com/kerikun11/.dotfiles/master/tools/manjaro_setup.sh | bash
# Linux Mint 19.3
curl -fsSL https://raw.githubusercontent.com/kerikun11/.dotfiles/master/tools/mint_setup.sh | sh
```

## mirror list

```sh
# Manjaro
Server = http://ftp.riken.jp/Linux/manjaro/stable/$repo/$arch
Server = http://ftp.tsukuba.wide.ad.jp/Linux/manjaro/stable/$repo/$arch
# Ubuntu 20.04
deb https://linux.yz.yamagata-u.ac.jp/ubuntu/ focal main
deb-src https://linux.yz.yamagata-u.ac.jp/ubuntu/ focal main
# Ubuntu 18.04
deb https://linux.yz.yamagata-u.ac.jp/ubuntu/ bionic main
deb-src https://linux.yz.yamagata-u.ac.jp/ubuntu/ bionic main
```

## .zshenv

```sh
# MSYS2
export PATH="$PATH:/c/Windows"
alias e="/c/Windows/explorer.exe"
alias code="'/c/Users/kerikun11/AppData/Local/Programs/Microsoft VS Code/Code.exe'"
alias m="mingw32-make -j 8"
```
