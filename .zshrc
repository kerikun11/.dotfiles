## Environment variable configuration
export LANG=ja_JP.UTF-8

# 色を使用
autoload -Uz colors
colors
export LSCOLORS=cxfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# プロンプト
PROMPT="%{${fg[green]}%}%~ \$%{${reset_color}%} "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{${fg[red]}%}${HOST%%.*} ${PROMPT}"

# 補完機能の強化
autoload -U compinit
compinit
# 補完に関するオプション
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt print_eight_bit       # 日本語ファイル名等8ビットを通す
setopt extended_glob         # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots              # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt list_packed           # リストを詰めて表示
bindkey "^I" menu-complete   # 展開する前に補完候補を出させる(Ctrl-iで補完するようにする)
zstyle ':completion:*:default' menu select=2 # 補完候補を ←↓↑→ でも選択出来るようにする
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字小文字を無視して補完

# 移動関係
bindkey -e                   # Emacsキーバインドで移動
setopt auto_cd               # cdを使わずにディレクトリを移動できる
setopt auto_pushd            # "cd -"の段階でTabを押すと、ディレクトリの履歴が見れる

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

# ヒストリー
setopt share_history          # 他のターミナルとヒストリーを共有
setopt histignorealldups      # ヒストリーに重複を表示しない
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# alias
alias la="ls -al --color=auto"
alias lf="ls -F"
alias ll="ls -l --color=auto"
alias make="make -j8"
alias here="explorer.exe ."
alias pd="pushd"
alias pp="popd"

# PATH
export PATH=$PATH:'/c/Program Files (x86)/Nordic Semiconductor/nrf5x/bin'
export PATH=$PATH:'/c/Program Files (x86)/SEGGER/JLink_V630k'
export PATH=$PATH:'/usr/local/bin/xtensa-esp32-elf/bin'
export PATH=$PATH:'/usr/local/bin/xtensa-lx106-elf/bin'
export IDF_PATH="$HOME/OneDrive/Application/Espressif/esp-idf"
