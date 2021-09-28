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

    set signcolumn=number
    set isfname+=@-@
    set cmdheight=1
    set so=6
    set updatetime=300
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
    set nowritebackup
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
    Plug 'leafOfTree/vim-vue-plugin'
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'evanleck/vim-svelte', {'branch': 'main'}
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'codechips/coc-svelte', {'do': 'npm install'}
    Plug 'Shougo/context_filetype.vim'
    Plug 'preservim/nerdcommenter'
    Plug 'dbakker/vim-projectroot'
    Plug 'tpope/vim-surround'
    Plug 'mileszs/ack.vim'

    Plug 'MarcWeber/vim-addon-mw-utils'
    Plug 'tomtom/tlib_vim'
    Plug 'garbas/vim-snipmate'
    Plug 'grvcoelho/vim-javascript-snippets'
call plug#end()


inoremap jj <ESC>
inoremap kk <ESC>l
xnoremap <leader> <ESC>

" nnoremap <leader>ls :'<','>s/; /\r/<cr>

nmap <leader>vo :vsplit ~/.vimrc<cr>
nmap <leader>vr :so ~/.vimrc<cr>
nmap <leader>q :q!<cr>
nmap <leader>ga :Git add<cr>
nmap <leader>qq :qa!<cr>
nmap <leader>w :w!<cr>
nmap <leader>ww :wa!<cr>
nmap <leader>wq :mksession! \| :wqa!<cr>
nmap <leader>n :NERDTreeToggle<cr>
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

if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif

let g:context_filetype#filetypes.svelte =
            \ [
\   {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
\   {
\     'filetype': 'typescript',
\     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
\     'end': '',
\   },
\   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
\ ]

let g:ft = ''

" NERDCommenter settings

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = { 'html': { 'left': '' } }

" Align comment delimiters to the left instead of following code indentation
let g:NERDDefaultAlign = 'left'

fu! NERDCommenter_before()
  if (&ft == 'html') || (&ft == 'svelte')
    let g:ft = &ft
    let cfts = context_filetype#get_filetypes()
    if len(cfts) > 0
      if cfts[0] == 'svelte'
        let cft = 'html'
      elseif cfts[0] == 'scss'
        let cft = 'css'
      else
        let cft = cfts[0]
      endif
      exe 'setf ' . cft
    endif
  endif
endfu

fu! NERDCommenter_after()
  if (g:ft == 'html') || (g:ft == 'svelte')
    exec 'setf ' . g:ft
    let g:ft = ''
  endif
endfu

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

let g:ackprg = 'ag --nogroup --nocolor --column'
