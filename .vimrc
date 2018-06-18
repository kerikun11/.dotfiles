" *****************************
" .vimrc
" kerikun11
" *****************************

" *****************************
" 総合設定
" *****************************
"文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
" 入力されているテキスト最大幅を無効にする
set textwidth=0
" backspace function
set backspace=start,eol,indent
" mouse support
set mouse=a
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title

" *****************************
" 見た目
" *****************************
" syntax hilight
syntax enable
" color theme
colorscheme desert
" 行番号を表示
set number
" 不可視文字を表示する
set list
" タブと行の続きを可視化する
set listchars=tab:>-
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
" 現在の行を強調表示
set cursorline
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" コマンドラインの補完
set wildmode=list:longest
" カッコのハイライトをなくす
let loaded_matchparen = 1


" *****************************
" 操作性
" *****************************
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 左右スクロール時の視界を確保
set scrolloff=8
" OSのクリップボードをヤンクと共有
set clipboard=unnamed,unnamedplus
" 折り畳み
set foldmethod=indent

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" *****************************
" 検索関係
" *****************************
" 検索結果をハイライト表示する
set hlsearch
" 検索ワードの最初の文字を入力した時点で検索を開始する
set incsearch
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>