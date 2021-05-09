# file: $env:userprofile/Documents/WindowsPowerShell/profile.ps1
# description: configration file for PowerShell
# author: kerikun11

# aliases
Set-Alias open start
Set-Alias o open
Set-Alias p python
Set-Alias e echo
Set-Alias c code

# open this file
function profile.ps1() {
    code $env:userprofile/Documents/WindowsPowerShell/profile.ps1
}

# for google colab session
function periodic_open($url) {
    for ($i=0; $i -lt 10; $i++){
        start chrome $url
        Start-Sleep -s 10
    }
}
