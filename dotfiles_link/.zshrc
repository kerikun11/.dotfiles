##============================================================================##
## file:   $HOME/.zshrc
## author: Ryotaro Onuki <kerikun11+github@gmail.com>
## date:   2021.10.31
##============================================================================##
## zsh plugin manager https://github.com/tarjoilija/zgen
[ ! -d $HOME/.zgen ] && git clone https://github.com/tarjoilija/zgen $HOME/.zgen
ZGEN_RESET_ON_CHANGE=($HOME/.zshrc)
source $HOME/.zgen/zgen.zsh
##============================================================================##
## install plugins
if ! zgen saved; then
    ## oh-my-zsh snippets
    zgen oh-my-zsh lib/clipboard.zsh  # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/clipboard.zsh
    zgen oh-my-zsh lib/completion.zsh # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh
    zgen oh-my-zsh lib/functions.zsh  # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/functions.zsh
    zgen oh-my-zsh lib/history.zsh    # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
    zgen oh-my-zsh plugins/copybuffer # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copybuffer
    # zgen oh-my-zsh plugins/vi-mode    # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
    ## other plugins
    zgen load ael-code/zsh-colored-man-pages             # https://github.com/ael-code/zsh-colored-man-pages
    zgen load peterhurford/git-it-on.zsh                 # https://github.com/peterhurford/git-it-on.zsh
    zgen load zsh-users/zsh-autosuggestions              # https://github.com/zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions                  # https://github.com/zsh-users/zsh-completions
    zgen load mollifier/anyframe                         # https://github.com/mollifier/anyframe
    zgen load zdharma-continuum/fast-syntax-highlighting # https://github.com/zdharma-continuum/fast-syntax-highlighting
    zle_highlight=('paste:none')                         # https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/105
    ## zsh theme
    zgen load romkatv/powerlevel10k powerlevel10k # https://github.com/romkatv/powerlevel10k
    ## my zsh plugins
    zgen load $HOME/.dotfiles/config/zsh
    ## ending; don't put any settings bellow zgen save
    zgen save
fi
