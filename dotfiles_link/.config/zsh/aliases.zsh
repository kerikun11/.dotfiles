##============================================================================##
## author: Ryotaro Onuki <kerikun11+github@gmail.com>
## date: 2021.06.01
##============================================================================##
## custom aliases
alias gsettings_list='gsettings list-recursively'
alias od-ascii='od -tx1z -Ax'
alias serve='python3 -m http.server'
alias takebuild='take build' # call oh-my-zsh function
alias tree-git='tree -a -I .git'
alias zshenv='$EDITOR $HOME/.zshenv'
alias zshrc='$EDITOR $HOME/.zshrc'

## initial aliases
alias c='code'
alias cdg='cd $(git rev-parse --show-toplevel)'
alias dr='docker'
alias drb='docker build'
alias drc='docker container'
alias drcs='docker-compose'
alias dri='docker images'
alias drr='docker run'
alias drrme='docker run --rm -i -t --network host -u $(id -u):$(id -g) -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v $PWD:/w -w /w'
alias drrmex11='docker run --rm -i -t --network host -u $(id -u):$(id -g) -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v $PWD:/w -w /w --tmpfs $HOME -v $HOME/.Xauthority:$HOME/.Xauthority:ro -e DISPLAY'
alias drrrm='docker run --rm -i -t'
alias drv='docker volume'
alias e='echo'
alias g='git'
alias gg='git log --graph --oneline'
alias gga='git log --graph --oneline --all'
alias gu='echo "$(git config --get user.name) <$(git config --get user.email)>"'
alias h='history'
alias hs='history | grep -i'
alias l='ls -lha'
alias la='ls -la'
alias ll='ls -l'
alias ls='ls --color=auto'
alias lsa='ls -a'
alias m='make'
alias n='ninja'
alias o='open'
alias p='python'
alias p2='python2'
alias p3='python3'
alias r='exec zsh' # reload zsh
alias ssc='sudo systemctl'
alias sst='sudo systemctl status'
alias se='sudoedit'
alias sv='serve'
alias tb='take build' # call oh-my-zsh function
alias wh='which'

## command replace
alias grep='grep --color=auto'
alias make='make -j$(nproc)'
alias open='open_command' # call oh-my-zsh function
type bat &>/dev/null && alias cat='bat'
type exa &>/dev/null && alias ls='exa -g'
type trash-put &>/dev/null && alias rm='trash-put'

## global aliases
alias -g A='2>&1 | tee -a'
alias -g C='| clipcopy' # call oh-my-zsh function
alias -g F='| fzf'
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less -R'
alias -g P='| peco'
alias -g T='| tail'
alias -g W='| wc -l'
alias -g X='| xargs'

## date string
alias datestr='date +%Y%m%d'
alias datetimestr='date +%Y%m%d-%H%M%S'

## long command alias
alias upgradeall='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean'
alias sp2ub='find . -name "* *" | rename -v "s/ /_/g"'

## esp-idf alias
alias idf_='export IDF_PATH=/opt/espressif/esp-idf    && . $IDF_PATH/export.sh'
alias idf3='export IDF_PATH=/opt/espressif/esp-idf_v3 && . $IDF_PATH/export.sh'
alias idf4='export IDF_PATH=/opt/espressif/esp-idf_v4 && . $IDF_PATH/export.sh'
alias idf='idf.py'
alias idfbuild='idf.py build'
alias idfflashmonitor='idf.py -b 2000000 flash monitor'
alias idfmonitor='idf.py monitor'
alias idfmenuconfig='idf.py menuconfig'

## PDF n-up
alias pdfnup2x1='pdfnup --batch --a4paper --nup 2x1 --scale 1.0  --landscape'
alias pdfnup2x2='pdfnup --batch --a4paper --nup 2x2 --scale 0.96 --landscape'
alias pdfnup2x4='pdfnup --batch --a4paper --nup 2x4 --scale 0.96 --no-landscape'

## Exiftool
alias rmgeotag='exiftool -overwrite_original -geotag='

##============================================================================##
## directory aliases
# hash -d dot=~/.dotfiles

##============================================================================##
## functions
function chpwd() { ls; }
function svg2pdf() { inkscape -D -z --file=$1 --export-pdf=${1%.*}.pdf; }
function permission-reset() {
  find $1 -type d -print | xargs chmod 755
  find $1 -type f -print | xargs chmod 644
}
function local-ip() {
  echo $(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
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
  yes | pv | ssh $* "cat >/dev/null"
}
function ssh-del-known_hosts-line() {
  sed -i ${1}d $HOME/.ssh/known_hosts
}
function kd() {
  echo -n 'sh -c "$(wget -qO - kerislab.jp/d)"' | clipcopy
}
##============================================================================##
