##============================================================================##
## file:   .zshrc
## author: Ryotaro Onuki <kerikun11+github@gmail.com>
## date:   2021.05.30
##============================================================================##
## zinit https://github.com/zdharma/zinit
test ! -f $HOME/.zinit/bin/zinit.zsh &&
  sh -c "$(curl -fsSL https://raw.github.com/zdharma/zinit/master/doc/install.sh)"
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit
##============================================================================##
zinit light mollifier/anyframe                     # https://github.com/mollifier/anyframe
zinit light paulirish/git-open                     # https://github.com/paulirish/git-open
zinit light supercrabtree/k                        # https://github.com/supercrabtree/k
zinit light zdharma/fast-syntax-highlighting       # https://github.com/zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions          # https://github.com/zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions              # https://github.com/zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search # https://github.com/zsh-users/zsh-history-substring-search
zinit light jimeh/zsh-peco-history                 # https://github.com/jimeh/zsh-peco-history
##============================================================================##
zinit ice depth=1
zinit light romkatv/powerlevel10k # https://github.com/romkatv/powerlevel10k
##============================================================================##
zinit snippet OMZL::clipboard.zsh # clipcopy
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::functions.zsh # take, open
zinit snippet OMZL::git.zsh
zinit snippet OMZL::grep.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZP::archlinux
zinit snippet OMZP::copybuffer
zinit snippet OMZP::extract
zinit snippet OMZP::git
zinit snippet OMZP::tmux
zinit snippet OMZP::ubuntu
zinit snippet OMZP::vi-mode
##============================================================================##
## key bind
bindkey -s '^]' '\e'        # fix escape key
bindkey "^[[3~" delete-char # fix delete key
bindkey '^z' undo           # undo
bindkey '^y' redo           # redo
bindkey "^o" copybuffer     # copy
## vi-mode
KEYTIMEOUT=1 # shorten vi-mode switching delay
## pushd
setopt auto_pushd pushd_ignore_dups pushdminus auto_cd
cdpath=(~)
# setopt nonomatch # Execute command even if no match with glob
##============================================================================##
autoload -Uz compinit
compinit
##============================================================================##
source $HOME/.dotfiles/tools/zsh/aliases.zsh
source $HOME/.dotfiles/tools/zsh/sshcode.zsh
source $HOME/.dotfiles/tools/zsh/extension.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
##============================================================================##
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
bindkey '^R' peco_select_history
