##============================================================================##
## file:   .zshrc
## author: Ryotaro Onuki <kerikun11+github@gmail.com>
## date:   2021.05.29
##============================================================================##
## Path to your oh-my-zsh installation. (required)
export ZSH="$HOME/.oh-my-zsh"
## oh-my-zsh Theme, see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"
## to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
## vi-mode settings
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE="true"
## oh-my-zsh plugins
plugins=(
  docker
  docker-compose
  extract
  fast-syntax-highlighting # .oh-my-zsh/custom/plugins/fast-syntax-highlighting
  git
  pip
  vi-mode
)
## to reflect oh-my-zsh configurations
source $ZSH/oh-my-zsh.sh
##============================================================================##
## sshcode
source $HOME/.dotfiles/tools/zsh/sshcode.zsh
##============================================================================##
## editor
type vim &>/dev/null && export EDITOR='vim'
type code &>/dev/null && export EDITOR='code'
##============================================================================##
## fix ys theme
PROMPT="%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$fg[white]%}@ \
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info}\
${venv_info}\
 \
%{$fg[white]%}[%*] $exit_code
"'${${VI_KEYMAP/vicmd/"%{$terminfo[bold]$fg[yellow]%}"}/(main|viins)/"%{$terminfo[bold]$fg[red]%}"}$ %{$reset_color%}'
function ys_precmd() { print; }
autoload -U add-zsh-hook
add-zsh-hook precmd ys_precmd
##============================================================================##
## vi mode
bindkey -v                  # vi keybind
bindkey -s '^]' '\e'        # fix escape key
bindkey "^[[3~" delete-char # fix delete key
KEYTIMEOUT=1                # shorten mode switching delay
## allow ctrl-r and ctrl-s to search the history
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
## allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
## allow ctrl-z, ctrl-y for undo redo
bindkey '^z' undo
bindkey '^y' redo
## Yank to the system clipboard
function vi-yank-xclip() {
  zle vi-yank
  echo "$CUTBUFFER" | clipcopy
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip
##============================================================================##
## stack command
function show_buffer_stack() {
  zle -M "stack: ${BUFFER}"
  zle push-line-or-edit
}
zle -N show_buffer_stack
bindkey '^q' show_buffer_stack
##============================================================================##
## zsh opts
# setopt nonomatch # Execute command even if no match with glob
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
alias gu='echo "$(git config --get user.name) <$(git config --get user.email)>"'
alias kd="echo -n 'source <(curl -fsSL kerislab.jp/d)' | clipcopy"
alias la="ls -lha"
alias ll="ls -lh"
alias m="make"
alias n="ninja"
alias o="open"
alias p="python"
alias p2="python2"
alias p3="python3"
alias r="exec zsh" # reload
alias s="serve"
alias tb="take build" # call oh-my-zsh function

## command replace
alias make="make -j$(nproc)"
alias open="open_command" # call oh-my-zsh function
type bat &>/dev/null && alias cat="bat"
type exa &>/dev/null && alias ls="exa -g" && alias la="ls -lah"
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
hash -d dot=~/.dotfiles

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
