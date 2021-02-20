#!/bin/sh

## command to find settings: gsettings list-recursively

## Cinnamon
gsettings set org.cinnamon.desktop.screensaver lock-enabled false
gsettings set org.cinnamon.muffin placement-mode 'pointer' # new window placement
gsettings set org.cinnamon.settings-daemon.peripherals.touchpad horizontal-scrolling true
gsettings set org.cinnamon.settings-daemon.plugins.power idle-brightness 5
gsettings set org.cinnamon.settings-daemon.plugins.power idle-dim-time 30
gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-ac-action 'nothing'
gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-battery-action 'nothing'
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 3600               # diplay off
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-battery 3600          # diplay off
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-battery-timeout 3600 # sleep PC
gsettings set org.cinnamon.settings-daemon.plugins.xsettings buttons-have-icons true         # theme -> misc
gsettings set org.cinnamon.settings-daemon.plugins.xsettings menus-have-icons true           # theme -> misc
echo "OK Cinnamon"

## Nemo
gsettings set org.nemo.desktop show-desktop-icons false
gsettings set org.nemo.preferences default-folder-viewer 'list-view'
gsettings set org.nemo.window-state start-with-menu-bar false
## tool bar
gsettings set org.nemo.preferences show-compact-view-icon-toolbar true
gsettings set org.nemo.preferences show-computer-icon-toolbar true
gsettings set org.nemo.preferences show-edit-icon-toolbar true
gsettings set org.nemo.preferences show-home-icon-toolbar true
gsettings set org.nemo.preferences show-new-folder-icon-toolbar true
gsettings set org.nemo.preferences show-open-in-terminal-toolbar true
gsettings set org.nemo.preferences show-reload-icon-toolbar true
echo "OK nemo"
