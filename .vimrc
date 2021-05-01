let mapleader = " "

" Sets how many lines of history VIM has to remember
set history=500
"
" Enable filetype plugins
filetype plugin on
filetype indent on
syntax enable

au FocusGained,BufEnter * checktime

" SETTINGS

    set foldcolumn=0

    set mouse=
    set wildmenu
    set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
    set ruler
    set guicursor=
    set t_Co=256

" Error bells
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500

    " set signcolumn=yes
    set isfname+=@-@
    set cmdheight=1
    set so=6
    set updatetime=50
    set shortmess+=c
    set hidden

    set backspace=eol,start,indent
    set whichwrap+=<,>,h,l
    set nowrap

" Numbers and setting relative number
    set nu
    set relativenumber
    set cursorline

" White spacing
    set smarttab
    set tabstop=2 softtabstop=2 shiftwidth=2
    set expandtab
    set smartindent
    set ai
    set si

" Swap Performance
    set noswapfile
    set nobackup
    set undodir=~/.vim/undodir
    set undofile

" Searching
    set ignorecase
    set smartcase
    set incsearch
    set nohlsearch
    set magic

" PLUGINS
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree' 
    Plug 'tpope/vim-fugitive' 
    Plug 'ryanoasis/vim-devicons'
    Plug 'posva/vim-vue'
    Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
    Plug 'junegunn/fzf.vim'
    Plug 'KarimElghamry/vim-auto-comment'
call plug#end()

inoremap jj <ESC>
nmap <leader>vo :vsplit ~/.vimrc<cr>
nmap <leader>vr :so ~/.vimrc<cr>
nmap <leader>q :q!<cr>
nmap <leader>w :w!<cr>
nmap <leader>nn :NERDTreeToggle<cr>
nmap <leader>ff :Files %:p:h<cr>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

highlight ColorColumn ctermbg=DarkGrey ctermfg=Red
highlight netrwDir guifg=#5eacd3
highlight qfFileName guifg=#aed75f
highlight LineNr ctermfg=DarkGrey
highlight FoldColumn ctermbg=20
highlight clear CursorLine
highlight CursorLine cterm=bold ctermbg=235

highlight CursorLineNr cterm=bold ctermfg=230 ctermbg=236
autocmd InsertEnter * highlight CursorLine cterm=none ctermbg=none
autocmd InsertLeave * highlight CursorLine cterm=bold ctermbg=236
