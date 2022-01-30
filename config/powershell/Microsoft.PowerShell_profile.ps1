# filepath: $env:userprofile/Documents/WindowsPowerShell/profile.ps1
# description: configration file for PowerShell
# author: kerikun11
# allow script execution
#   $ gsudo Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
# allow symlink to general user
#   https://kokufu.blogspot.com/2018/03/symbolic-link-privilege-not-held.html
# make symlink
#   New-Item -Type SymbolicLink $PROFILE -Value $env:userprofile/.dotfiles/config/powershell/Microsoft.PowerShell_profile.ps1 

# aliases
Set-Alias c code
Set-Alias dr docker
Set-Alias e echo
Set-Alias g git
Set-Alias o open
Set-Alias open start
Set-Alias p python
Set-Alias ll ls
Set-Alias u ubuntu

# open this file
function profile.ps1() {
    code $PROFILE
}

# for google colab session
function periodic_open($url) {
    for ($i=0; $i -lt 10; $i++){
        start chrome $url
        Start-Sleep -s 10
    }
}

# switch to msys terminal
function zsh() {
    $env:MSYS="winsymlinks:nativestrict"
    $env:CHERE_INVOKING=1
    $env:MSYS2_PATH_TYPE="strict"
    $env:MSYSTEM="MINGW64"
    $env:SHELL="/usr/bin/zsh"
    C:/msys64/usr/bin/zsh.exe --login
}
