##============================================================================##
# file:   .zshrc
# author: Ryotaro Onuki <kerikun11+github@gmail.com>
# date:   2020.10.24
##============================================================================##
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
##============================================================================##
# Path to your oh-my-zsh installation. (required)
export ZSH="$HOME/.oh-my-zsh"
# oh-my-zsh Theme, see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
# oh-my-zsh plugins
plugins=(
  git
  pip
  copybuffer # copy command buffer with Ctrl-O
  fast-syntax-highlighting
)
# to reflect oh-my-zsh configurations
source $ZSH/oh-my-zsh.sh
##============================================================================##
# sshcode
source $HOME/.dotfiles/tools/zsh/sshcode.zsh
##============================================================================##
# editor
type vim  &>/dev/null && export EDITOR='vim'
type code &>/dev/null && export EDITOR='code'
##============================================================================##
# vi mode
bindkey -v # vi keybind
bindkey -s '^]' '\e'        # fix escape key
bindkey "^[[3~" delete-char # fix delete key
KEYTIMEOUT=1                # shorten mode switching delay
# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
# allow ctrl-r and ctrl-s to search the history
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
# allow ctrl-u, ctrl-j for navigate history
bindkey '^u' up-history
bindkey '^j' down-history
# allow ctrl-z, ctrl-y for undo redo
bindkey '^z' undo
bindkey '^y' redo
# Yank to the system clipboard
function vi-yank-xclip() {
  zle vi-yank
  echo "$CUTBUFFER" | clipcopy
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip
##============================================================================##
# stack command
function show_buffer_stack() {
  zle -M "stack: ${BUFFER}"
  zle push-line-or-edit
}
setopt noflowcontrol # disable ctrl-s and ctrl-q
zle -N show_buffer_stack
bindkey '^q' show_buffer_stack
##============================================================================##
# custom alias
alias c="code"
alias e="echo"
alias g="git"
alias m="make"
alias o="open"
alias n="ninja"
alias p="python"
alias r="source $HOME/.zshrc"
alias zshrc="$EDITOR $HOME/.zshrc"
alias zshenv="$EDITOR $HOME/.zshenv"
alias open="open_command" # call oh-my-zsh function
alias make="make -j$(nproc) --quiet"
alias takebuild="take build" # call oh-my-zsh function
alias copy="clipcopy"

# command replace
type trash-put  &>/dev/null && alias rm=trash-put
type bat        &>/dev/null && alias cat=bat
type batcat     &>/dev/null && alias cat=batcat
type exa        &>/dev/null && alias ls=exa && alias la="ls -lah"

# date string
alias datestr="date +%Y%m%d"
alias datetimestr="date +%Y%m%d-%H%M%S"

# long command alias
alias upgradeall="sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean"
alias sp2ub='find . -name "* *" | rename "s/ /_/g"'

# esp-idf docker alias
alias idf_='export IDF_PATH=/usr/local/Espressif/esp-idf && . $IDF_PATH/export.sh'
alias idf3='export IDF_PATH=/usr/local/Espressif/esp-idf_v3 && . $IDF_PATH/export.sh'
alias idf4='export IDF_PATH=/usr/local/Espressif/esp-idf_v4 && . $IDF_PATH/export.sh'
alias idf="idf.py"

# PDF n-up
alias pdfnup2x1="pdfnup --a4paper --nup 2x1 --scale 1.0 --landscape --batch"
alias pdfnup2x2="pdfnup --a4paper --nup 2x2 --scale 0.96 --landscape --batch"
alias pdfnup2x4="pdfnup --a4paper --nup 2x4 --scale 0.96 --no-landscape --batch"

# Exiftool
alias rmgeotag="exiftool -overwrite_original -geotag="

# functions
function chpwd() {
  ls
}
function svg2pdf() {
  inkscape -D -z --file=$1 --export-pdf=${1%.*}.pdf
}
function permission_reset() {
  find $1 -type d -print | xargs chmod 755
  find $1 -type f -print | xargs chmod 644
}
function tree_git() {
  git ls-tree -r --name-only HEAD $1 | tree --fromfile
}
function gclc() {
  # git clone code, $1: URL, $2: path
  git clone --recursive $1 $2 && code ${2:-${$(basename $1)%.git}}
}
##============================================================================##
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
##============================================================================##
