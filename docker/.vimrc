set encoding=utf-8
scriptencoding utf-8
set modeline
let g:vim_indent_cont=8
set fileencodings=utf-8,cp932,sjis,utf-16le,euc-jp
set fileformats=unix,dos,mac

execute pathogen#infect()
execute pathogen#helptags()
syntax enable
filetype plugin indent on

set notitle
set ruler
set laststatus=2
set showmode
set showcmd
set textwidth=0
set number
set autoindent
set smartindent
set smarttab
set backspace=indent,eol,start
set complete=.,w,b,u,t
set completeopt=menuone
set formatoptions+=j
set noautoread
set timeout timeoutlen=600 ttimeoutlen=100
set wildmenu
set scrolloff=1
set sidescrolloff=3
set nrformats=
set hidden
set ignorecase
set smartcase
set infercase
set incsearch
set hlsearch
set wrapscan
set noundofile
set nobackup
set noswapfile

" for vim-fireplace and piggieback
let g:fireplace_cljs_repl =
	\ '(cider.piggieback/cljs-repl (figwheel.main.api/repl-env "dev"))'

" for rainbow parentheses
let g:rbpt_max = 8
autocmd VimEnter * RainbowParenthesesToggle
