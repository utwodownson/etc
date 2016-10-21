" don't bother with vi compatibility
set nocompatible

" enable syntax highlighting
syntax on

" configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
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
set tags=tags
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
set mouse-=a
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

" NERD tree
let NERDChristmasTree=0
let NERDTreeChDirMode=2
let NERDTreeWinSize=35
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$', '\.o']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
" Automatically open a NERDTree if no files where specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
" let g:tagbar_left=1
let g:tagbar_vertical=20

" plugin settings
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:CommandTMaxHeight=20
let g:gitgutter_enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="serene"
let g:Powerline_symbols='fancy'
let g:ackprg='ag --nogroup --column' " ZOMG the_silver_searcher is so much faster than ack
set t_Co=256

" set scheme
set background=dark
let g:solarized_termtrans = 0
let g:solarized_degrade = 1
let g:solarized_bold = 0
"let g:solarized_underline = 1
let g:solarized_italic = 1
let g:solarized_contrast = "high"
let g:solarized_visibility= "high"
colorscheme solarized
set t_Co=256                        " force vim to use 256 colors
let g:solarized_termcolors=256      " use solarized 256 fallback

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" cscope
if has("cscope")
set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
    " check cscope for definition of a symbol before checking ctags:
    " set to 1 if you want the reverse search order.
    set csto=1

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB !=""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose

    nmap <C-/>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-/>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-/>d :cs find d <C-R>=expand("<cword>")<CR><CR>
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

map <F5> :call CompileRunGplusplus()<CR>
func! CompileRunGplusplus()
     exec "w"
     exec "!g++ % -o %<"
     exec "! ./%<"
endfunc
