##============================================================================##
# .zshrc
# author: Ryotaro Onuki <kerikun11+github@gmail.com>
# date: 2020.06.27
##============================================================================##
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" &&
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" ||
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zinit-zsh/z-a-rust \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
##============================================================================##
### Added by kerikun11
# zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit load zdharma/history-search-multi-word
zinit light paulirish/git-open
zinit light supercrabtree/k

##============================================================================##
# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

##============================================================================##
# Oh-My-Zsh
COMPLETION_WAITING_DOTS="true"
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::theme-and-appearance.zsh
zinit snippet OMZP::git
zinit cdclear -q # <- forget completions provided up to this moment

##============================================================================##
# vi mode
bindkey -v
bindkey -s '^]' '\e'        # fix escape
bindkey "^[[3~" delete-char # fix delete
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

##============================================================================##
# completion
zinit ice blockf
zinit light zsh-users/zsh-completions
# zinit creinstall zsh-users/zsh-completions   # install
# zinit cuninstall zsh-users/zsh-completions   # uninstall

autoload -U compinit && compinit -C

##============================================================================##
## new alias
alias ll="k"
alias la="k -a"

# custom alias
alias g="git"
alias m="make"
alias p="python"
alias n="ninja"
alias c="code"
alias r='source ~/.zshrc' # reload
alias open="open_command" # oh-my-zsh function
alias make="make -j 8 --quiet"

# command replace
type trash-put &>/dev/null && alias rm=trash-put
type bat &>/dev/null && alias cat=bat
type batcat &>/dev/null && alias cat=batcat

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

# stack command
show_buffer_stack() {
  zle -M "stack: ${BUFFER}"
  zle push-line-or-edit
}
setopt noflowcontrol # disable ctrl-s and ctrl-q
zle -N show_buffer_stack
bindkey '^Q' show_buffer_stack

# copy command
clipcopy-buffer(){
  print -rn $BUFFER | clipcopy
  zle -M "clipboard: ${BUFFER}"
  zle kill-whole-line
}
zle -N clipcopy-buffer
bindkey '^x' clipcopy-buffer

# functions
function chpwd() {
  ll
}
function svg2pdf() {
  inkscape -D -z --file=$1 --export-pdf=${1%.*}.pdf
}
function permission_reset() {
  find $1 -type d -print | xargs chmod 755 && find $1 -type f -print | xargs chmod 644
}
function tree_git() {
  git ls-tree -r --name-only HEAD $1 | tree --fromfile
}
### End of Zinit's installer chunk
### End of Zinit's installer chunk
