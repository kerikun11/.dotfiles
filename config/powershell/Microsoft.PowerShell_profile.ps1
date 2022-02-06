## filepath: $PROFILE (PoserShell Variable)
## description: configration file for PowerShell
## author: kerikun11
## setup:
##   1. clone .dotfiles
##      $ git clone git@github.com:kerikun11/.dotfiles.git $HOME/.dotfiles
##   2. allow script execution
##      $ gsudo Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
##   3. allow symlink to general user
##      see https://kokufu.blogspot.com/2018/03/symbolic-link-privilege-not-held.html
##   4. make symlink
##      $ New-Item -Force -Type SymbolicLink $PROFILE -Value $HOME/.dotfiles/config/powershell/Microsoft.PowerShell_profile.ps1
##   5. make VSCode Settings link
##      $ New-Item -Force -Type SymbolicLink $HOME/AppData/Roaming/Code/User/keybindings.json -Value $HOME/.dotfiles/dotfiles_link/.config/Code/User/keybindings.json
##      $ New-Item -Force -Type SymbolicLink $HOME/AppData/Roaming/Code/User/settings.json -Value $HOME/.dotfiles/dotfiles_link/.config/Code/User/settings.json
##   6. enable git completion
##      $ Install-Module -Name posh-git -Scope CurrentUser -Force

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
function profile () {
    code $PROFILE
}

## sshcode
function sshcode ($target_host, $target_path) {
    ## usage
    function usage () {
        Write-Host "usage:    sshcode target_host [target_path]"
        Write-Host ""
        Write-Host "example:  sshcode user@host           # brank window"
        Write-Host "example:  sshcode user@host Documents # rel path to $HOME"
        Write-Host "example:  sshcode user@host /foo/bar  # abs path"
    }
    ## check host
    if ($target_host -eq $null) { usage ; return }
    ## convert path if path does not start with "/" (regarded as relative to home dir)
    if (!($target_path -eq $null) -and (!$target_path.StartsWith("/"))) {
        $target_home = ssh -x $target_host pwd # get home dir
        $target_path = "$target_home/$target_path"
    }
    ## open ssh-remote code
    ## https://code.visualstudio.com/docs/remote/troubleshooting#_connect-to-a-remote-host-from-the-terminal
    if ($target_path -eq $null) {
        code --remote ssh-remote+$target_host
    } else {
        code --folder-uri vscode-remote://ssh-remote+$target_host$target_path
    }
}

## for google colab session keep
function periodic_open ($url) {
    for ($i=0; $i -lt 10; $i++){
        Start chrome $url
        Start-Sleep -s 10
    }
}

## switch to msys terminal
function zsh () {
    $env:CHERE_INVOKING=1
    $env:MSYS="winsymlinks:nativestrict"
    $env:MSYS2_PATH_TYPE="inherit" # strict or inherit
    $env:MSYSTEM="MINGW64"
    $env:SHELL="/usr/bin/zsh"
    C:/msys64/usr/bin/zsh.exe --login
}
