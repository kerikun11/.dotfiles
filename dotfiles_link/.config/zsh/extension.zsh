##============================================================================##
## anyframe; interactive command/file search
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin    # https://github.com/junegunn/fzf/releases
zinit light mollifier/anyframe # https://github.com/mollifier/anyframe
zstyle ":anyframe:selector:" use fzf
zstyle ":anyframe:selector:fzf:" command 'fzf --reverse --no-sort --exact --info=inline'
if type fzf &>/dev/null; then
  bindkey '^g' anyframe-widget-cd-ghq-repository
  bindkey '^k' anyframe-widget-kill
  # bindkey '^h' anyframe-widget-put-history
  function select-history() {
    BUFFER=$(history -n -r 1 | fzf --reverse --no-sort --exact --query "$LBUFFER" | sed 's/\\n/\n/g')
    CURSOR=$#BUFFER
  }
  zle -N select-history
  bindkey '^j' select-history
fi
##============================================================================##
## completion waiting dots
expand-or-complete-with-dots() {
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
