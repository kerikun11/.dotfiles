# kerikun11/.dotfiles

My Configuration Files for UNIX Systems

## Install .dotfiles Automatically

See [install.sh](./install.sh) for details.

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
REQUIREMENTS="curl git zsh";\
type sudo   &>/dev/null && test "$(whoami)" != "root" && SUDO="sudo" || SUDO="";\
type apt    &>/dev/null && $SUDO apt update -q && $SUDO apt install -yq $REQUIREMENTS;\
type pacman &>/dev/null && $SUDO pacman -Sy -q --noconfirm --needed     $REQUIREMENTS;\
type apk    &>/dev/null && $SUDO apk add -q                             $REQUIREMENTS;\
type yum    &>/dev/null && $SUDO yum install -yq                        $REQUIREMENTS;\
sh -c "$(curl -fsSL https://raw.github.com/kerikun11/.dotfiles/main/install.sh)"
```

## Useful Commands

```sh
## Allow me to run sudo without password
echo "$USER ALL=NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo
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

```sh
# Configure qemu-user-static
sudo docker run --rm --privileged multiarch/qemu-user-static --reset --persistent yes
```

```sh
# Configure Swap File
SWAP_SIZE=16G
sudo fallocate -l $SWAP_SIZE /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab
```

## Instant Shell Theme

```sh
## Bash Instant Prompt Theme
PS1='\n\[\e[0;31m\]# \[\e[0;32m\]\u \[\e[0m\]@ \[\e[0;36m\]\h \[\e[0m\]in \[\e[0;33m\]\w \[\e[0;37m\]\D{%Y/%m/%d} \t\n\[\e[0;34m\]\$ \[\e[0m\]'
```

```sh
## Zsh Instant Prompt Theme
PROMPT=$'\n''%F{red}# %F{green}%n %F{white}@ %F{cyan}%m %F{white}in %F{yellow}%~ %F{240}%D{%Y/%m/%d} %*'$'\n''%F{blue}%# %f'
```

## Bash

```sh
## ignore case at completion
S="set completion-ignore-case on" F="$HOME/.inputrc" && grep "$S" $F &>/dev/null || echo "$S" >> $F
## realtime history
S="HISTFILESIZE=10000" F="$HOME/.bashrc" && grep "$S" $F &>/dev/null || echo "$S" >> $F
S="PROMPT_COMMAND='history -a; history -r'" F="$HOME/.bashrc" && grep "$S" $F &>/dev/null || echo "$S" >> $F
## prompt customize
S="PS1='\n\[\e[0;31m\]# \[\e[0;32m\]\u \[\e[0m\]@ \[\e[0;36m\]\h \[\e[0m\]in \[\e[0;33m\]\w \[\e[0;37m\]\D{%Y/%m/%d} \t\n\[\e[0;34m\]\$ \[\e[0m\]'" F="$HOME/.bashrc" && grep "$S" $F &>/dev/null || echo "$S" >> $F
```

## SSH-Agent

```sh
## ssh-agent
SSH_AGENT_FILE=/tmp/.ssh-agent
source $SSH_AGENT_FILE &> /dev/null
if ! ssh-add -l &> /dev/null; then
    ssh-agent > $SSH_AGENT_FILE
    source $SSH_AGENT_FILE &> /dev/null
    ssh-add
fi
```

## Dockerfile

```sh
# Add an user to a group
sudo gpasswd --add $USER docker && newgrp docker
```

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

## PowerShell

```ps1
## Link PowerShell Profile
New-Item -Force -Type SymbolicLink `
    $PROFILE `
    -Value $HOME/.dotfiles/config/powershell/Microsoft.PowerShell_profile.ps1
```
