## filepath: $PROFILE
## description: configration file for PowerShell
## author: kerikun11
## setup:
##   1. allow script execution
##      $ gsudo Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
##   2. allow symlink to general user
##      see https://kokufu.blogspot.com/2018/03/symbolic-link-privilege-not-held.html
##   3. make symlink
##      $ New-Item -Force -Type SymbolicLink $PROFILE -Value $HOME/.dotfiles/config/powershell/Microsoft.PowerShell_profile.ps1
##   4. make VSCode Settings
##      $ New-Item -Force -Type SymbolicLink $HOME/AppData/Roaming/Code/User/keybindings.json -Value $HOME/.dotfiles/dotfiles_link/.config/Code/User/keybindings.json
##      $ New-Item -Force -Type SymbolicLink $HOME/AppData/Roaming/Code/User/settings.json -Value $HOME/.dotfiles/dotfiles_link/.config/Code/User/settings.json

## env vars
$env:DISPLAY = "localhost:0.0"
$env:PATH = "C:/opt/ManjaroWSL;$env:PATH"
$env:PATH = "C:/opt/Arch;$env:PATH"

## 補完を bash 風にする
Set-PSReadLineKeyHandler -Key Tab -Function Complete
## キーバインドを emacs 風にする
Set-PSReadlineOption -EditMode Emacs
## ビープ音を無効化
Set-PSReadlineOption -BellStyle None

## substitution
Set-Alias open start
Set-Alias grep Select-String

## aliases
function ga { git add $args }
function gad { git add . $args }
function gcl { git clone $args }
function gd { git diff $args }
function gf { git fetch $args }
function gph { git push $args }
function gpl { git pull $args }
function gst { git status $args }
function gsu { git submodule update --init --recursive $args }
function m { wsl -d Manjaro $args }
Set-Alias c code
Set-Alias dr docker
Set-Alias e echo
Set-Alias g git
Set-Alias ll ls
Set-Alias o open
Set-Alias p python
Set-Alias u ubuntu

## open this file
function profile.ps1() {
    code $PROFILE
}

## for google colab session keep
function periodic_open($url) {
    for ($i=0; $i -lt 10; $i++){
        Start chrome $url
        Start-Sleep -s 10
    }
}

## switch to msys terminal
function zsh() {
    $env:CHERE_INVOKING=1
    $env:MSYS="winsymlinks:nativestrict"
    # $env:MSYS2_PATH_TYPE="strict"
    $env:MSYSTEM="MINGW64"
    $env:SHELL="/usr/bin/zsh"
    C:/msys64/usr/bin/zsh.exe --login
}
