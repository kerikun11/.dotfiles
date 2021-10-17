# kerikun11/.dotfiles

My Configuration Files for UNIX Systems

## Install .dotfiles Automatically

See [install.sh](install.sh) for detail.

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
```

```sh
## Ubuntu Mirror Lists
sudo sed -i.bak -e 's%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g' /etc/apt/sources.list
cat /etc/apt/sources.list | sed -e '/^#/d' -e '/^$/d' # show entries
```

```sh
## Ubuntu Desktop Settings
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
LANG=C xdg-user-dirs-gtk-update # rename home dirs in English
```

```sh
## Open GNOME Control Center in SSH X11 Forwarding Env
sudo -E XDG_CURRENT_DESKTOP=GNOME gnome-control-center
```

## Instant Prompt Theme

```sh
## Bash Instant Prompt Theme
export PS1='
\[\e[0;31m\]# \[\e[0;32m\]\u \[\e[0m\]@ \[\e[0;36m\]\h \[\e[0m\]in \[\e[0;33m\]\w \[\e[0;37m\]\t (bash)
\[\e[0;34m\]\$ \[\e[0m\]'
```

```sh
## Zsh Instant Prompt Theme
export PROMPT='
%F{red}# %F{green}%n %F{white}@ %F{cyan}%m %F{white}in %F{yellow}%~ %F{240}%*
%F{blue}%# %f'
```

```sh
## Zsh Syntax Highlighting
git clone --depth=1 https://github.com/zdharma/fast-syntax-highlighting ~/.fast-syntax-highlighting
source ~/.fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
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
