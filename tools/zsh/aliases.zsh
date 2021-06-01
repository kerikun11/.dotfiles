##============================================================================##
## author: Ryotaro Onuki <kerikun11+github@gmail.com>
## date: 2021.06.01
##============================================================================##
## custom aliases
alias od-ascii="od -tx1z -Ax"
alias serve="python3 -m http.server"
alias takebuild="take build" # call oh-my-zsh function
alias zshenv="$EDITOR $HOME/.zshenv"
alias zshrc="$EDITOR $HOME/.zshrc"
alias gsettings_list="gsettings list-recursively"
## initial aliases
alias c="code"
alias cdg='cd $(git rev-parse --show-toplevel)'
alias dr="docker"
alias drb="docker build"
alias drcs="docker-compose"
alias dri="docker images"
alias drr="docker run --rm -it"
alias e="echo"
alias g="git"
alias gu='echo "$(git config --get user.name) <$(git config --get user.email)>"'
alias kd="echo -n 'source <(curl -fsSL kerislab.jp/d)' | clipcopy"
alias l="ls -lha"
alias la="ls -a"
alias ll="ls -lh"
alias lla="ls -lha"
alias ls="ls --color=auto"
alias m="make"
alias n="ninja"
alias o="open"
alias p="python"
alias p2="python2"
alias p3="python3"
alias r="exec zsh" # reload
alias s="serve"
alias tb="take build" # call oh-my-zsh function
alias wh="which"

## command replace
alias make="make -j$(nproc)"
alias open="open_command" # call oh-my-zsh function
type bat &>/dev/null && alias cat="bat"
type exa &>/dev/null && alias ls="exa -g"
type trash-put &>/dev/null && alias rm="trash-put"

## global aliases
alias -g A='2>&1 | tee -a'
alias -g C='| clipcopy' # call oh-my-zsh function
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less -R'
alias -g T='| tail'
alias -g W='| wc -l'
alias -g X='| xargs'
alias -g P='| peco'

## date string
alias datestr="date +%Y%m%d"
alias datetimestr="date +%Y%m%d-%H%M%S"

## long command alias
alias upgradeall="sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean"
alias sp2ub='find . -name "* *" | rename -v "s/ /_/g"'

## esp-idf alias
alias idf_='export IDF_PATH=/usr/local/Espressif/esp-idf    && . $IDF_PATH/export.sh'
alias idf3='export IDF_PATH=/usr/local/Espressif/esp-idf_v3 && . $IDF_PATH/export.sh'
alias idf4='export IDF_PATH=/usr/local/Espressif/esp-idf_v4 && . $IDF_PATH/export.sh'
alias idf="idf.py"
alias idfbuild="idf.py build"
alias idfflashmonitor="idf.py -b 2000000 flash monitor"
alias idfmonitor="idf.py monitor"
alias idfmenuconfig="idf.py menuconfig"

## PDF n-up
alias pdfnup2x1="pdfnup --batch --a4paper --nup 2x1 --scale 1.0  --landscape"
alias pdfnup2x2="pdfnup --batch --a4paper --nup 2x2 --scale 0.96 --landscape"
alias pdfnup2x4="pdfnup --batch --a4paper --nup 2x4 --scale 0.96 --no-landscape"

## Exiftool
alias rmgeotag="exiftool -overwrite_original -geotag="

## directory alias
# hash -d dot=~/.dotfiles

##============================================================================##
## functions
function chpwd() { ls; }
function tree-git() { git ls-tree -r --name-only HEAD $1 | tree --fromfile; }
function svg2pdf() { inkscape -D -z --file=$1 --export-pdf=${1%.*}.pdf; }
function permission-reset() {
  find $1 -type d -print | xargs chmod 755
  find $1 -type f -print | xargs chmod 644
}
function local-ip() {
  echo $(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
}
function datetimediff() {
  echo start time:
  read ts
  echo end time:
  read te
  ts=$(date -d "${ts:0:19}" +%s)
  te=$(date -d "${te:0:19}" +%s)
  echo ""
  echo "$((te - ts)) [s]"
  echo "$(((te - ts) / 3600)):$(date --utc +"%M:%S" -d @$(($te - $ts)))"
}
function make-dockerfile-runnable() {
  alias ARG="export"
  alias ENV="export"
  alias RUN=""
  alias COPY="rsync -av"
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
##============================================================================##
