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
zinit snippet OMZL::history.zsh     # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
zinit snippet OMZP::copybuffer      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copybuffer
zinit snippet OMZP::extract         # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract
zinit snippet OMZP::git             # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
zinit snippet OMZP::vi-mode         # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
##============================================================================##
## zinit plugins
zinit light paulirish/git-open             # https://github.com/paulirish/git-open
zinit light zsh-users/zsh-autosuggestions  # https://github.com/zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions      # https://github.com/zsh-users/zsh-completions
zinit light ael-code/zsh-colored-man-pages # https://github.com/ael-code/zsh-colored-man-pages
##============================================================================##
## zsh syntax highlighting
zinit light zdharma/fast-syntax-highlighting # https://github.com/zdharma/fast-syntax-highlighting
zle_highlight=('paste:none')                 # https://github.com/zdharma/fast-syntax-highlighting/issues/105
##============================================================================##
## zsh theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
zinit ice depth=1 && zinit light romkatv/powerlevel10k # https://github.com/romkatv/powerlevel10k
##============================================================================##
## zsh options; see $ man zshoptions
setopt auto_cd             # execute only directory name to change dir
setopt nonomatch           # avoid error when no match with glob
setopt interactivecomments # allow comments when interactive mode
function chpwd() { ls; }   # run ls after cd
##============================================================================##
## key bind
bindkey -s '^]' '\e'        # fix escape key in vscode terminal
bindkey '^[[3~' delete-char # fix delete key
bindkey '^z' undo
bindkey '^y' redo
## vi-mode option
KEYTIMEOUT=1 # shorten vi-mode switching delay
##============================================================================##
source $HOME/.config/zsh/aliases.zsh 2>/dev/null
source $HOME/.config/zsh/sshcode.zsh 2>/dev/null
source $HOME/.config/zsh/extension.zsh 2>/dev/null
##============================================================================##
type vim &>/dev/null && export EDITOR='vim'
##============================================================================##
