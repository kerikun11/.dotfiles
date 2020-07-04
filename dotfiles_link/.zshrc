##============================================================================##
# .zshrc
# author: Ryotaro Onuki <kerikun11+github@gmail.com>
# date: 2020.06.27
##============================================================================##
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
##============================================================================##
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    fast-syntax-highlighting
    pip
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

##============================================================================##
# additional configuration
export EDITOR='vim'

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
# Yank to the system clipboard
function vi-yank-xclip {
  zle vi-yank
  echo "$CUTBUFFER" | clipcopy
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip
##============================================================================##
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

# functions
function svg2pdf() {
  inkscape -D -z --file=$1 --export-pdf=${1%.*}.pdf
}
function permission_reset() {
  find $1 -type d -print | xargs chmod 755 && find $1 -type f -print | xargs chmod 644
}
function tree_git() {
  git ls-tree -r --name-only HEAD $1 | tree --fromfile
}
function chpwd() {
  ls
}
##============================================================================##
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
##============================================================================##
