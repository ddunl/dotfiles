set encoding=utf-8

let mapleader=" "

set backspace=2 
set history=50
set ruler
set showcmd
set incsearch
set wildmenu
set laststatus=2
set autowrite

" tabs stuff
set sw=4
set tabstop=4

" no arrows!!
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Down> :echoe "Use h"<CR>
nnoremap <Up> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use h"<CR>


nnoremap q <nop> "ignore macro recording for now
nnoremap <Leader>rel :source $MYVIMRC<CR>

"this is a test comment
