##============================================================================##
## Description: Zsh Aliases
## Copyright 2021 Ryotaro Onuki <kerikun11+github@gmail.com>
## Last Modified: 2021.06.01
##============================================================================##
## global aliases
alias -g C='| clipcopy' # call oh-my-zsh function
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less -R'
alias -g T='| tail'
alias -g V='| vim -R -'
alias -g W='| wc -l'
alias -g X='| xargs'

## command replace
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias ls='ls --color=auto'
alias make='make -j$(nproc)'

## short aliases
alias c='code'
alias dfr='df -h /'
alias e='echo'
alias f='find'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias h='history -i'
alias ha='history -i 1'
alias ip4='ip -4'
alias ip6='ip -6'
alias l='ls'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias lsa='ls -a'
alias m='make'
alias mdp='mkdir -p'
alias n='ninja'
alias o='open' # call oh-my-zsh function
alias p='python'
alias p2='python2'
alias p3='python3'
alias r='exec zsh' # reload zsh
alias rf='readlink -f'
alias s='sudo'
alias se='sudoedit'
alias ssc='sudo systemctl'
alias sst='sudo systemctl status'
alias sv='serve'
alias tb='take build' # call oh-my-zsh function
alias v='vim'
alias wh='which'

## git aliases
alias cd-git-top='cd $(git rev-parse --show-toplevel)'
alias gt='git rev-parse --show-toplevel'
alias g='git'
alias ga='git add'
alias gad='git add .'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gcar='git commit --amend --reset-author'
alias gcarn='git commit --amend --reset-author --no-edit'
alias gcl='git clone'
alias gclr='git clone --recursive'
alias gcld='git clone --depth=1'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcaw='git diff --cached --word-diff'
alias gdw='git diff --word-diff'
alias gf='git fetch'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias gfp='git fetch --prune'
alias gg='git log --all --graph'
alias gg1="git log --all --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'"
alias gg2="git log --all --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
alias ggo='git log --all --graph --oneline'
alias git-tree='tree -a -I .git'
alias git-user='echo "$(git config --get user.name) <$(git config --get user.email)>"'
alias glg='git log'
alias gph='git push'
alias gpl='git pull'
alias grb='git rebase'
alias gre='git restore'
alias gst='git status'
alias gsu='git submodule update --init --recursive'
alias gsw='git switch'

## docker aliases
alias dr='docker'
alias drb='docker build'
alias drc='docker container'
alias drcs='docker-compose'
alias dri='docker images'
alias drps='docker ps'
alias drr='docker run'
alias drrrmit='docker run --rm -i -t'
alias drrrmitme='docker run --rm -i -t --network=host -u=$(id -u):$(id -g) -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v $PWD:/w -w /w --tmpfs=$HOME'
alias drrrmitmex11='docker run --rm -i -t --network=host -u=$(id -u):$(id -g) -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v $PWD:/w -w /w --tmpfs=$HOME -v $HOME/.Xauthority:$HOME/.Xauthority:ro -e DISPLAY'
alias drv='docker volume'

## dirs
alias d='dirs -v'
alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias ..='cd ..'
alias ...='cd ...'

## date string
alias ds='date +%Y%m%d'             # date string
alias dt='date +%Y%m%d-%H%M%S'      # date time
alias dtu='date +%s.%N'             # UNIX
alias dti='date --iso-8601=seconds' # ISO

## custom aliases
alias gsettings_list='gsettings list-recursively'
alias od-ascii='od -tx1z -Ax'
alias open='open_command' # call oh-my-zsh function
alias serve='python3 -m http.server'
alias sp2ub='find . -name "* *" | rename -v "s/ /_/g"'
alias upgradeall='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean'
alias zsh-startup='for i in $(seq 1 10); do time zsh -i -c exit; done'
alias zshenv='$EDITOR $HOME/.zshenv'
alias zshrc='$EDITOR $HOME/.zshrc'
alias rmgeotag='exiftool -overwrite_original -geotag='
alias local-ip='ip route get 8.8.8.8 | sed -n "/src/{s/.*src *\([^ ]*\).*/\1/p;q}"'
alias trim-comment-lines="sed -e '/^\s*$/d' -e '/^\s*#.*/d"

## esp-idf alias
alias idf_='export IDF_PATH=/opt/espressif/esp-idf    && . $IDF_PATH/export.sh'
alias idf3='export IDF_PATH=/opt/espressif/esp-idf_v3 && . $IDF_PATH/export.sh'
alias idf4='export IDF_PATH=/opt/espressif/esp-idf_v4 && . $IDF_PATH/export.sh'
alias idf='idf.py'
alias idfbuild='idf.py build'
alias idfflashmonitor2m='idf.py -b 2000000 flash monitor'
alias idfflashmonitor='idf.py flash monitor'
alias idfmonitor='idf.py monitor'
alias idfmenuconfig='idf.py menuconfig'

## PDF n-up
alias pdfnup2x1='pdfnup --batch --a4paper --nup 2x1 --scale 1.0  --landscape'
alias pdfnup2x2='pdfnup --batch --a4paper --nup 2x2 --scale 0.96 --landscape'
alias pdfnup2x4='pdfnup --batch --a4paper --nup 2x4 --scale 0.96 --no-landscape'

##============================================================================##
## directory aliases
# hash -d dot=~/.dotfiles

##============================================================================##
## functions
function svg2pdf() { inkscape -D -z --file=$1 --export-pdf=${1%.*}.pdf; }
function permission-reset() {
  find $1 -type d -print | xargs chmod 755
  find $1 -type f -print | xargs chmod 644
}
function datetimediff() {
  # log format: "2021.02.03 12:34:56 xxx"
  echo start time:
  read ts
  echo end time:
  read te
  ts=$(date -d "${ts:0:19}" +%s)
  te=$(date -d "${te:0:19}" +%s)
  echo
  echo "$((te - ts)) [s]"
  echo "$(((te - ts) / 3600)):$(date --utc +"%M:%S" -d @$(($te - $ts)))"
}
function make-dockerfile-runnable() {
  alias ARG='export'
  alias ENV='export'
  alias RUN=''
  alias COPY='rsync -av'
  echo '$ source Dockerfile'
}
function periodic-open() {
  while true; do
    open $@
    seconds=$((30 * 60))
    while [ $seconds -gt 0 ]; do
      echo -ne "\t$seconds\033[0K\r"
      sleep 1
      : $((seconds--))
    done
  done
}
function ssh-speed-test() {
  [ "$#" -lt 1 ] && echo "usage: $ $0 hostname" && return 1
  yes | pv | ssh "$@" "cat >/dev/null"
}
function kd() {
  echo -n 'sh -c "$(D=kerislab.jp/d; curl -fsSL $D || wget -qO - $D)"' | clipcopy
}
##============================================================================##
