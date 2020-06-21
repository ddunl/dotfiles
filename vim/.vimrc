set encoding=utf-8
"gruvbox theme
syntax on
set background=dark
"this fixes tmux colors somehow lol
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif
"fix terminal colors in popup window
let g:terminal_ansi_colors = [
			\ "#282828", "#cc241d", "#98971a", "#d79921",
			\ "#458588", "#b16286", "#689d6a", "#a89984",
			\ "#928374", "#fb4934", "#b8bb26", "#fabd2f",
			\ "#83a598", "#d3869b", "#8ec07c", "#ebdbb2"
			\]
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_bold=1

colorscheme gruvbox

let mapleader=" "

set backspace=2 
set history=50
set ruler
set showcmd
set incsearch
set wildmenu
set laststatus=2
set autowrite
set number
set noshowmode
" tabs stuff
set sw=4
set tabstop=4
set autoindent
set smartindent
set noexpandtab
"weird fuzzyfinder probably worse than fzf though
set path+=**
set wildmenu
"tab and space chars
set list
set listchars=eol:¬,tab:▸-
" no arrows!!
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Down> :echoe "Use j"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Right> :echoe "Use l"<CR>

"ignore macro recording for now
nnoremap q <nop> 

"reload vimrc
nnoremap <Leader>rel :source $MYVIMRC<CR>

"autocomplete brackets - still looking for more sublime-eqsue to beat this
inoremap {<CR> {<CR>}<Esc>O

function! Flt_term_win(cmd, width, height, border_highlight, title) abort
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    let bufnr = term_start(a:cmd, {'hidden': 1, 'term_finish': 'close', 'cwd': getcwd()})

    let winid = popup_create(bufnr, {
            \ 'minwidth': width,
            \ 'maxwidth': width,
            \ 'minheight': height,
            \ 'maxheight': height,
            \ 'border': [],
            \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
            \ 'borderhighlight': [a:border_highlight],
            \ 'padding': [0,1,0,1],
            \ 'highlight': a:border_highlight,
			\ 'title': a:title
            \ })

    " Optionally set the 'Normal' color for the terminal buffer
   	" call setwinvar(winid, '&wincolor', 'Special')
	let b:termid = winid
	echo b:termid
    return winid
endfunction

"commands for open popup shell and run python in interactive mode	
nnoremap <buffer> <leader>sh :call Flt_term_win('bash', 0.9, 0.6, 'Todo', ' bash')<CR>
nnoremap <buffer> <leader>b :call Flt_term_win('python3 -i '.expand('%:p'), 0.9, 0.9, 'Todo'," " . expand('%'))<CR>
"compile tex on save
autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!
"commands for switching windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

"netrw settings
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

"open netrw in good split
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>


