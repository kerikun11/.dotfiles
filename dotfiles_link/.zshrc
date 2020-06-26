# author: Ryotaro Onuki <kerikun11+github@gmail.com>
# date: 2020.06.27

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"
DEFAULT_USER="kerikun11"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode docker pip zsh-syntax-highlighting)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

####
#### User configuration
####

# fix * behavior
unsetopt nomatch

# key map fix in vi-mode
bindkey -s '^]' '\e'        # escape
bindkey "^[[3~" delete-char # delete

# custom alias
alias g="git"
alias m="make"
alias p="python"
alias n="ninja"
alias c="code"
alias r='source ~/.zshrc' # reload
alias open="open_command" # oh-my-zsh function
alias make="make -j 8 --quiet"

# long alias
alias upgradeall="sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean"
alias sp2ub='find . -name "* *" | rename "s/ /_/g"'

# esp-idf docker alias
alias idf='docker run --rm -v $PWD:/project -w /project -it -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -u $(id -u $USER):$(id -g $USER) espressif/idf'
alias idfd='docker run --rm -v $PWD:/project -w /project -it -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -u $(id -u $USER):$(id -g $USER) --device=$(ls /dev/ttyUSB*) espressif/idf'
alias idf4='export IDF_PATH=/usr/local/Espressif/esp-idf_v4 && . $IDF_PATH/export.sh'
alias idf3='export IDF_PATH=/usr/local/Espressif/esp-idf_v3 && . $IDF_PATH/export.sh'

# PDF n-up
alias pdfnup2x1="pdfnup --a4paper --nup 2x1 --scale 1.0 --landscape --batch"
alias pdfnup2x2="pdfnup --a4paper --nup 2x2 --scale 0.96 --landscape --batch"
alias pdfnup2x4="pdfnup --a4paper --nup 2x4 --scale 0.96 --no-landscape --batch"

# Exiftool
alias rmgeotag="exiftool -overwrite_original -geotag="

# Trash CLI
if type trash-put &>/dev/null; then
  alias rm=trash-put
fi

# command stack
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack

# functions
function chpwd() {
  ls -l --color=auto
}
function svg2pdf() {
  inkscape -D -z --file=$1 --export-pdf=${1%.*}.pdf
}
function permission_reset() {
  find $1 -type d -print | xargs chmod 755 && find $1 -type f -print | xargs chmod 644
}
function gt() {
  git ls-tree -r --name-only HEAD $1 | tree --fromfile
}
