filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin List goes here
Plugin 'vim-airline/vim-airline'
Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'file:///home/tichomir/local/opt/vim-misc'
Plugin 'file:///home/tichomir/local/opt/vim-easytags'
Plugin 'file:///home/tichomir/local/opt/tagbar'
Plugin 'file:///home/tichomir/local/opt/syntastic'
Plugin 'airblade/vim-gitgutter'
" Plugin 'vim-plugin-minibufexpl/vim-plugin-minibufexpl'
" Plugin 'file:///home/tichomir/local/opt/vim-plugin-minibufexpl'
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'

call vundle#end()            " required
filetype plugin indent on    " required

set laststatus=2
set showtabline=0

nmap <F8> :TagbarToggle<CR>

" let g:airline#extensions#tabline#enabled = 1
let g:airline_exclude_preview = 1
if has("gui_running")
    let g:airline_powerline_fonts = 1
endif

" Enable mouse support inside terminals
set ttyfast
set mouse=a
set ttymouse=xterm2

" vim-gitgutter option
set updatetime=250
nmap <F7> :GitGutterLineHighlightsToggle<CR>
nmap <F2> :b#<CR>

:colorscheme ron
:syntax on

inoremap <UP> <nop>
inoremap <DOWN> <nop>
inoremap <LEFT> <nop>
inoremap <RIGHT> <nop>

nnoremap <UP> <nop>
nnoremap <DOWN> <nop>
nnoremap <LEFT> <nop>
nnoremap <RIGHT> <nop>

nnoremap <F4> :bnext<CR>
nnoremap <F3> :bprevious<CR>
nnoremap <F5> :b#<CR>

" Scroll screen so as the cursor is at the center of the screen
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

set expandtab
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

"set noexpandtab     " Don't expand TABs to spaces

set hidden          "Enable hidden buffers

set noswapfile	    "Do not create backup .swp files

syntax on

" Always display line numbers
set number
