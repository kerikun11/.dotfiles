#!/bin/sh

## command to find settings: gsettings list-recursively

## find settings with GUI:
## gsettings list-recursively > /tmp/prev
## (change settings with GUI)
## gsettings list-recursively > /tmp/post
## diff /tmp/prev /tmp/post

## Cinnamon
gsettings set org.cinnamon.desktop.screensaver lock-enabled false
gsettings set org.cinnamon.desktop.wm.preferences action-scroll-titlebar 'opacity'
gsettings set org.cinnamon.desktop.wm.preferences mouse-button-modifier '<Super>'
gsettings set org.cinnamon.muffin placement-mode 'pointer'
gsettings set org.cinnamon.settings-daemon.peripherals.touchpad horizontal-scrolling true
gsettings set org.cinnamon.settings-daemon.plugins.power idle-brightness 5
gsettings set org.cinnamon.settings-daemon.plugins.power idle-dim-time 60
gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-ac-action 'nothing'
gsettings set org.cinnamon.settings-daemon.plugins.power lid-close-battery-action 'nothing'
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 3600               # display off
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-battery 3600          # display off
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-inactive-battery-timeout 3600 # suspend
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
echo "OK nemo"

## GNOME Terminal
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
echo "OK gnome terminal"

## Keyboard Shortcuts
# dconf dump /org/cinnamon/desktop/keybindings/media-keys/
# dconf dump /org/cinnamon/desktop/keybindings/custom-keybindings/
## Custom
gsettings set org.cinnamon.desktop.keybindings custom-list "['custom0']"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom0/ name "Power Menu"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom0/ command "cinnamon-session-quit --power-off"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom0/ binding "['<Primary><Alt>Delete']"
## Media Keys
gsettings set org.cinnamon.desktop.keybindings.media-keys logout "@as []"
gsettings set org.cinnamon.desktop.keybindings.media-keys screensaver "['<Control><Alt>l', 'XF86ScreenSaver', '<Super>l']"
gsettings set org.cinnamon.desktop.keybindings.media-keys screenshot "['Print', '<Super>s']"
gsettings set org.cinnamon.desktop.keybindings.media-keys area-screenshot "['<Shift>Print', '<Shift><Super>s']"
gsettings set org.cinnamon.desktop.keybindings.media-keys window-screenshot "['<Alt>Print', '<Alt><Super>s']"
echo "OK Cinnamon Desktop Keyboard Shortcuts"
