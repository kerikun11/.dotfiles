syntax enable
set number
set autoindent
set smartindent
set backspace=start,eol,indent
set mouse=a
set tabstop=4
set shiftwidth=4
"set expandtab
set encoding=utf-8
set cursorline

set nocompatible

colorscheme desert

filetype plugin indent off

if has('vim_starting')
		set runtimepath+=~/.vim/bundle/neobundle.vim
		call neobundle#begin(expand('~/.vim/bundle'))
endif

NeoBundle 'mattn/emmet-vim'
NeoBundle 'anyakichi/vim-surround'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'taichouchou2/vim-javascript'
"NeoBundle 'tomasr/molokai'


if has('vim_starting')
		call neobundle#end()
endif

filetype plugin indent on

