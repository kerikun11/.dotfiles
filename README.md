# kerikun11/.dotfiles

My Configuration Files for UNIX Systems

## Install .dotfiles Automatically

```sh
## Install .dotfiles with curl
sh -c "$(curl -fsSL https://raw.github.com/kerikun11/.dotfiles/main/install.sh)"
```

```sh
## Install .dotfiles with wget
sh -c "$(wget -qO - https://raw.github.com/kerikun11/.dotfiles/main/install.sh)"
```

```sh
## Install Requirements before Install
REQUIREMENTS="curl git zsh"
type sudo   2>/dev/null && test "$(whoami)" != "root" && SUDO="sudo" || SUDO=""
type apt    2>/dev/null && $SUDO apt update -q && $SUDO apt install -yq $REQUIREMENTS
type pacman 2>/dev/null && $SUDO pacman -Sy -q --noconfirm --needed     $REQUIREMENTS
type apk    2>/dev/null && $SUDO apk add -q                             $REQUIREMENTS
type yum    2>/dev/null && $SUDO yum install -yq                        $REQUIREMENTS
sh -c "$(curl -fsSL https://raw.github.com/kerikun11/.dotfiles/main/install.sh)"
```

## Useful Commands

```sh
## allow me to run sudo without password
echo "$USER ALL=NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo
## Manjaro Mirror Lists
sudo pacman-mirrors -c Japan
## Ubuntu Mirror Lists
sudo sed -i.bak -e 's%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g' /etc/apt/sources.list
cat /etc/apt/sources.list | sed -e '/^#/d' -e '/^$/d' # show entries
## Ubuntu Desktop
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
LANG=C xdg-user-dirs-gtk-update # rename home dirs in English
## Open GNOME Control Center in SSH X11 Forwarding
sudo -E XDG_CURRENT_DESKTOP=GNOME gnome-control-center
```

## Apply Only Zsh Theme

```sh
# first install zsh git curl
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
curl -fsSL https://raw.github.com/kerikun11/.dotfiles/main/dotfiles_link/.p10k.zsh > ~/.p10k.zsh
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
echo 'source ~/.p10k.zsh' >>~/.zshrc
exec zsh -l
```

## Dockerfile

```dockerfile
## base image
FROM ubuntu
## install packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
## personal shell settings
RUN echo y | sh -c "$(curl -fsSL https://raw.github.com/kerikun11/.dotfiles/main/install.sh)"
CMD [ "zsh" ]
```
