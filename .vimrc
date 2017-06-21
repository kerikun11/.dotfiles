" *****************************
" .vimrc
" *****************************

" display line number
set number
" backspace function
set backspace=start,eol,indent
" mouse support
set mouse=a
" tab width
set tabstop=4
set shiftwidth=4
" encording
set encoding=utf-8
" display ruler
"set cursorline
set ruler
" error fix
set nocompatible
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" 入力中のコマンドを表示する
set showcmd
" 小文字のみで検索したときに大文字小文字を無視する
set smartcase
" 検索結果をハイライト表示する
set hlsearch
" 検索ワードの最初の文字を入力した時点で検索を開始する
set incsearch
" 不可視文字を表示する
set list
" タブと行の続きを可視化する
set listchars=tab:>-,trail:-,eol:$,extends:>,precedes:<,nbsp:.
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 左右スクロール時の視界を確保
set scrolloff=8
" OSのクリップボードをヤンクと共有
set clipboard=unnamed,unnamedplus
" 入力されているテキスト最大幅を無効にする
set textwidth=0
" 折り畳み
"set foldmethod=indent

" syntax hilight
syntax enable

" カッコのハイライトをなくす
let loaded_matchparen = 1

" color theme
colorscheme desert

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" *****************************
" NeoBundle
" *****************************
filetype plugin indent off
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#begin(expand('~/.vim/bundle'))
endif

NeoBundle 'mattn/emmet-vim'
NeoBundle 'anyakichi/vim-surround'
NeoBundle 'scrooloose/nerdcommenter'
" css3のシンタックスハイライトを表示
NeoBundle 'hail2u/vim-css3-syntax'
" HTML5のシンタックスハイライトを表示
"NeoBundle 'taichouchou2/html5.vim'
" 
NeoBundle 'taichouchou2/vim-javascript'
" vim-latexを使用可
NeoBundle 'vim-latex/vim-latex'
" 補完候補を表示
NeoBundle 'Shougo/neocomplete'
" rubyでendを自動で記述
NeoBundle 'tpope/vim-endwise'
" 複数行コメントをShift+Vで選択してCtrl+- Ctrl+-で実行
NeoBundle 'tomtom/tcomment_vim'
" インデントに色を付けて見やすく
NeoBundle 'nathanaelkane/vim-indent-guides'
" ステータスラインのハイライト表示
NeoBundle 'itchyny/lightline.vim'
" JavaScriptのインデント
NeoBundle 'pangloss/vim-javascript'
" 閉じカッコを自動的に挿入
NeoBundle 'Townk/vim-autoclose'
" Tree
NeoBundle 'nerdtree'
map <C-n> :NERDTreeToggle<CR>

if has('vim_starting')
	call neobundle#end()
endif
filetype plugin indent on


" *****************************
" vim-indent-guides
" *****************************
let g:indent_guides_enable_on_vim_startup=1

" *****************************
" NeoComplete
" *****************************
if neobundle#is_installed('neocomplete')
	" neocomplete用設定
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#enable_ignore_case = 1
	let g:neocomplete#enable_smart_case = 1
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns._ = '\h\w*'
elseif neobundle#is_installed('neocomplcache')
	" neocomplcache用設定
	let g:neocomplcache_enable_at_startup = 1
	let g:neocomplcache_enable_ignore_case = 1
	let g:neocomplcache_enable_smart_case = 1
	if
		!exists('g:neocomplcache_keyword_patterns')
		let g:neocomplcache_keyword_patterns = {}
	endif
	let	g:neocomplcache_keyword_patterns._ = '\h\w*'
	let g:neocomplcache_enable_camel_case_completion = 1
	let g:neocomplcache_enable_underbar_completion = 1
endif
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

"実行コマンド
command! Run call s:Run()
nmap <F5> :Run<CR>
function! s:Run()
  let e = expand("%:e")
  if e == "c"
    :Gcc
  endif
  if e == "py"
    :Python
  endif
  if e == "f90" || e == "f95"
    :Gfortran
  endif
endfunction

command! Python call s:Python()
function! s:Python()
  :!python %
endfunction

command! Gcc call s:Gcc()
function! s:Gcc()
  if has("win32") || has("win64")
    :!gcc % -o %:r.exe
    :!./%:r.exe
  else
    :!gcc % -o %:r.out
    :!./%:r.out
  endif
endfunction

command! Gfortran call s:Gfortran()
function! s:Gfortran()
  if has("win32") || has("win64")
    :!gfortran % -o %:r.exe
    :!./%:r.exe
  else
    :!gfortran % -o %:r.out
    :!./%:r.out
  endif
endfunction

