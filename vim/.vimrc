let mapleader = " "

" Sets how many lines of history VIM has to remember
set history=500
"
" Enable filetype plugins
filetype plugin on
filetype indent on
syntax enable

colo default

au FocusGained,BufEnter * checktime

" SETTINGS

    set foldcolumn=0
    set encoding=utf-8

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
    Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
    Plug 'junegunn/fzf.vim'
    Plug 'vim-scripts/npm'
    Plug 'KarimElghamry/vim-auto-comment'
    Plug 'leafOfTree/vim-vue-plugin'
    Plug 'tomtom/tcomment_vim'
    Plug 'sheerun/vim-polyglot'
call plug#end()

inoremap jj <ESC>
nmap <leader>vo :vsplit ~/.vimrc<cr>
nmap <leader>vr :so ~/.vimrc<cr>
nmap <leader>q :q!<cr>
nmap <leader>qq :qa!<cr>
nmap <leader>w :w!<cr>
nmap <leader>ww :wa!<cr>
nmap <leader>wq :wqa!<cr>
nmap <leader>nn :NERDTreeToggle<cr>
nmap <leader>ff :Files %:p:h<cr>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

nnoremap <c-w><space> :tab split<cr>
tnoremap <c-w><space> <c-w>:tab split<cr>

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

augroup NERD
    au!
    autocmd VimEnter * NERDTree
    autocmd VimEnter * wincmd p
augroup END
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! OnChangeVueSyntax(syntax)
  echom 'Syntax is '.a:syntax
  if a:syntax == 'html'
    setlocal commentstring=<!--%s-->
    setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
  elseif a:syntax =~ 'css'
    setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
  else
    setlocal commentstring=//%s
    setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
  endif
endfunction
