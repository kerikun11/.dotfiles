# kerikun11.dotfiles

My Configuration Files for UNIX Systems

```
         __      __  _____ __         
    ____/ /___  / /_/ __(_) /__  _____
   / __  / __ \/ __/ /_/ / / _ \/ ___/
 _/ /_/ / /_/ / /_/ __/ / /  __(__  ) 
(_)__,_/\____/\__/_/ /_/_/\___/____/  
                                      
```

## install .dotfiles

```sh
# install requirements
REQUIREMENTS="curl git zsh"
type sudo   2>/dev/null && test "$(whoami)" != "root" && SUDO="sudo" || SUDO=""
type apt    2>/dev/null && $SUDO apt update -q && $SUDO apt install -yq $REQUIREMENTS
type pacman 2>/dev/null && $SUDO pacman -Sy -q --noconfirm --needed $REQUIREMENTS
type apk    2>/dev/null && $SUDO apk add -q $REQUIREMENTS
type yum    2>/dev/null && $SUDO yum install -yq $REQUIREMENTS
# install dotfiles
curl -fsSL https://raw.github.com/kerikun11/.dotfiles/master/install.sh | sh
```

## useful commands

```sh
# Ubuntu Mirror Lists
sudo sed -i.bak -e 's%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g' /etc/apt/sources.list
cat /etc/apt/sources.list | sed -e '/^#/d' -e '/^$/d'
# Manjaro Mirror Lists
sudo pacman-mirrors -c Japan
# allow me to run sudo without password
echo "$USER ALL=NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo
```

## .zshenv

```sh
# MSYS2
alias code="'/c/Users/kerikun11/AppData/Local/Programs/Microsoft VS Code/bin/code'"
alias make="mingw32-make -j $(nproc) -s"
```
