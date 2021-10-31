##============================================================================##
## author: Ryotaro Onuki <kerikun11+github@gmail.com>
##============================================================================##
## env
type vim &>/dev/null && export EDITOR='vim'
##============================================================================##
## zsh options; see $ man zshoptions
function chpwd() { ls; }    # run ls after cd
setopt auto_cd              # execute only directory name to change dir
setopt auto_pushd           # pushd by cd
setopt hist_ignore_all_dups # remove old duplicated command in history list
setopt interactivecomments  # allow comments when interactive mode
setopt nonomatch            # avoid error when no match with glob
setopt pushd_ignore_dups    # ignore duplicated dir
setopt pushdminus           # set stack order naturally
##============================================================================##
## key bind
bindkey -v                  # use vi key bind
bindkey -s '^]' '\e'        # fix escape key in vscode terminal
bindkey '^[[3~' delete-char # fix delete key
bindkey '^z' undo
bindkey '^y' redo
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
## vi-mode option
KEYTIMEOUT=1 # shorten vi-mode switching delay
##============================================================================##
## anyframe settings # https://github.com/mollifier/anyframe
zstyle ":anyframe:selector:" use fzf
zstyle ":anyframe:selector:fzf:" command 'fzf --reverse --no-sort --exact --info=inline'
if type fzf &>/dev/null; then
  function select-history() {
    BUFFER=$(history -n -r 1 | fzf --reverse --no-sort --exact --query "$LBUFFER" | sed 's/\\n/\n/g')
    CURSOR=$#BUFFER
  }
  zle -N select-history
  bindkey '^j' select-history
  bindkey '^x^k' anyframe-widget-kill
  bindkey '^x^b' anyframe-widget-insert-git-branch
fi
##============================================================================##
## completion waiting dots
function expand-or-complete-with-dots() {
  print -Pn "%F{red}…%f"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey -M emacs "^I" expand-or-complete-with-dots
bindkey -M viins "^I" expand-or-complete-with-dots
bindkey -M vicmd "^I" expand-or-complete-with-dots
##============================================================================##
## command stack
function show_buffer_stack() {
  zle -M "stack: $BUFFER"
  zle push-line-or-edit
}
setopt noflowcontrol # disable ctrl-s and ctrl-q
zle -N show_buffer_stack
bindkey '^q' show_buffer_stack
