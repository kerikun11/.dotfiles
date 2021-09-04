##============================================================================##
## file:   .zshrc
## author: Ryotaro Onuki <kerikun11+github@gmail.com>
## date:   2021.06.05
##============================================================================##
## zsh plugin manager: zinit https://github.com/zdharma/zinit
test ! -f $HOME/.zinit/bin/zinit.zsh &&
  sh -c "$(curl -fsSL https://raw.github.com/zdharma/zinit/master/doc/install.sh)"
source "$HOME/.zinit/bin/zinit.zsh"
##============================================================================##
## oh-my-zsh snippets
zinit snippet OMZL::clipboard.zsh   # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/git.zsh
zinit snippet OMZL::completion.zsh  # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh
zinit snippet OMZL::directories.zsh # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh
zinit snippet OMZL::functions.zsh   # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/functions.zsh
zinit snippet OMZL::git.zsh         # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/git.zsh
zinit snippet OMZL::grep.zsh        # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/grep.zsh
zinit snippet OMZL::history.zsh     # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
zinit snippet OMZP::copybuffer      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copybuffer
zinit snippet OMZP::extract         # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract
zinit snippet OMZP::git             # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
zinit snippet OMZP::vi-mode         # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
##============================================================================##
## one-line plugins
zinit light paulirish/git-open               # https://github.com/paulirish/git-open
zinit light zdharma/fast-syntax-highlighting # https://github.com/zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions    # https://github.com/zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions        # https://github.com/zsh-users/zsh-completions
zle_highlight=('paste:none')                 # https://github.com/zdharma/fast-syntax-highlighting/issues/105
##============================================================================##
## zsh theme; see ~/.p10k.zsh
zinit ice depth=1 && zinit light romkatv/powerlevel10k # https://github.com/romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
##============================================================================##
## anyframe
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
setopt nonomatch # Execute command even if no match with glob
setopt hist_ignore_dups
setopt interactivecomments
##============================================================================##
type vim &>/dev/null && export EDITOR='vim'
source $HOME/.dotfiles/tools/zsh/aliases.zsh
source $HOME/.dotfiles/tools/zsh/sshcode.zsh
source $HOME/.dotfiles/tools/zsh/extension.zsh
##============================================================================##
