" don't bother with vi compatibility
set nocompatible

" enable syntax highlighting
syntax on

" configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
" call vundle#begin()
call vundle#rc()
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif
" call vundle#end() " ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on

" setting
set autoindent
set smartindent
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard
set fencs=utf-8,GB18030,ucs-bom,default,latin1
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                                                   " show line numbers
set backupdir=${HOME}/.vim/backup
set tags=./tags
set ruler                                                    " show where you are
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set tabstop=4
set pastetoggle=<F9>                                         " paste

autocmd FileType c setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType cpp setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType sh setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType bash setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType shell setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType html set tabstop=2
autocmd VimResized * :wincmd =
" autocmd BufWritePost ~/drive/* !ctags -f ~/drive/tags ~/drive/*
" automatically rebalance windows on vim resize

" Enable basic mouse behavior such as resizing buffers.
" set mouse=a
"if exists('$TMUX')  " Support resizing in tmux
"    set ttymouse=xterm2
":endif

" keyboard shortcuts
let mapleader = ','
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>l :Align
nnoremap <leader>a :Ag<space>
noremap <leader><leader> :Ack<space>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <leader>c <Plug>Kwbd
nnoremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" plugin settings
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:CommandTMaxHeight=20
let g:gitgutter_enabled = 0
let g:solarized_termcolors=256
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="serene"
let g:Powerline_symbols='fancy'
let g:ackprg='ag --nogroup --column' " ZOMG the_silver_searcher is so much faster than ack
set t_Co=256

" set scheme
set background=dark
" set background=light
colorscheme solarized

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

" Fix Cursor in TMUX
"if exists('$TMUX')
"  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"else
"  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"endif
"
" Go crazy!
if filereadable(expand("~/.vimrc.local"))
    " In your .vimrc.local, you might like:
    "
    " set autowrite
    " set nocursorline
    " set nowritebackup
    " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
    "
    " autocmd! bufwritepost .vimrc source ~/.vimrc
    " noremap! jj <ESC>
    source ~/.vimrc.local
endif
