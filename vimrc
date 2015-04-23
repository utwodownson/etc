" don't bother with vi compatibility
set nocompatible

" enable syntax highlighting
syntax on

" configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

" install Vundle bundles
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

" ensure ftdetect et al work by including this after the Vundle stuff
call vundle#end()
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
set backupdir=~/.vim/backup
set tags=./tags
set ruler                                                    " show where you are
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set tabstop=4

" Enable basic mouse behavior such as resizing buffers.
" set mouse=a
"if exists('$TMUX')  " Support resizing in tmux
"    set ttymouse=xterm2
":endif
set pastetoggle=<F9>

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
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" plugin settings
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:gitgutter_enabled = 0
let g:solarized_termcolors=256
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="serene"
let g:Powerline_symbols = 'fancy'
set t_Co=256
" set background=dark
" colorscheme solarized

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

autocmd FileType c setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType cpp setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType sh setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType bash setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType shell setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType html set tabstop=2
" autocmd BufWritePost ~/drive/* !ctags -f ~/drive/tags ~/drive/*
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

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
    " source ~/.bashrc
endif
