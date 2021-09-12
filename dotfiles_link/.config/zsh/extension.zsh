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
##============================================================================##
## yank to the system clipboard
function vi-yank-clipboard() {
  zle vi-yank
  echo "$CUTBUFFER" | clipcopy
}
zle -N vi-yank-clipboard
bindkey -M vicmd 'y' vi-yank-clipboard
##============================================================================##
