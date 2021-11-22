set encoding=utf-8

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
   silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
   Plug 'preservim/nerdtree'

   Plug 'tpope/vim-fugitive'
   Plug 'tpope/vim-commentary'
   Plug 'tpope/vim-surround'
   Plug 'tpope/vim-rhubarb'

   Plug 'nvim-lua/popup.nvim'
   Plug 'nvim-lua/plenary.nvim'
   Plug 'nvim-telescope/telescope.nvim'

   Plug 'nvim-lualine/lualine.nvim'
   Plug 'morhetz/gruvbox'
   Plug 'doums/lsp_spinner.nvim'
   
   Plug 'caenrique/nvim-toggle-terminal'
   Plug 'unblevable/quick-scope'

   Plug 'neovim/nvim-lspconfig'
   Plug 'hrsh7th/cmp-nvim-lsp'
   Plug 'hrsh7th/cmp-buffer'
   Plug 'hrsh7th/cmp-path'
   Plug 'hrsh7th/cmp-cmdline'
   Plug 'hrsh7th/nvim-cmp'

   Plug 'nvim-treesitter/nvim-treesitter', {'do' : ':TSUpdate'}

   Plug 'ap/vim-css-color'
call plug#end()


silent function! OSX()
    return has('macunix')
endfunction


"gruvbox theme
syntax on

"this fixes tmux colors somehow
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
set expandtab

set directory^=$HOME/.vim/swap//
set splitbelow
set splitright


set path+=**
set wildmenu
"tab and space chars
set list
set listchars=eol:¬,tab:▸-

set cc=100

"quickscope keys
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"reload vimrc
"nnoremap <Leader>rel :source $MYVIMRC<CR>

"reselect after indenting
vnoremap > >gv 
vnoremap < <gv

inoremap {<CR> {<CR>}<Esc>O

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"commands for toggle terminal
nnoremap <silent> <C-z> :ToggleTerminal<Enter>
nnoremap <silent> <leader>sh :ToggleTerminal<Enter>
tnoremap <silent> <C-z> <C-\><C-n>:ToggleTerminal<Enter>


"open nerdtree if no file is opened with vim
autocmd VimEnter * if !argc() | NERDTree | endif

"easy exit insert mode in terminal
tnoremap <Esc> <C-\><C-n>

nnoremap Y y$
"commands for switching windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <Up>    :resize -2<CR>
nnoremap <Down>  :resize +2<CR>
nnoremap <Left>  :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

nnoremap <leader>f :Files<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>g :Git 
nnoremap <leader>m :make

"text object for " as q
xnoremap iq i"
xnoremap aq a"
onoremap iq :normal vi"<CR>
onoremap aq :normal va"<CR>


" Completeopt for lsp, use <Tab> and <S-Tab> to navigate through popup menu
set completeopt=menu,menuone,noselect
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"yank to system clipboard
vnoremap <leader>y "+y
"opens gui file explorer at current dir
if OSX()
    nnoremap <leader>o :call system("open . &") <CR> 
else
    nnoremap <leader>o :call system("nohup nautilus . > /dev/null 2>&1 &") <CR>
endif

lua require("init")
