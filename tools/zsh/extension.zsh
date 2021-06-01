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
function vi-yank-xclip() {
  zle vi-yank
  echo "$CUTBUFFER" | clipcopy
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip
##============================================================================##
## peco ghq
function peco-src() {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^g' peco-src
##============================================================================##
