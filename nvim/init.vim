if (has("termguicolors"))
    set termguicolors
endif


call plug#begin()
    Plug 'kyazdani42/nvim-tree.lua'

    Plug 'tpope/vim-commentary'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'romainl/vim-qf'
    Plug 'morhetz/gruvbox'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

    Plug 'neovim/nvim-lspconfig'

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/vim-vsnip'
call plug#end()

let g:gruvbox_termcolors=16
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_bold=1
colorscheme gruvbox


syntax on
let mapleader=" "

set backspace=2 
set history=50
set ruler
set showcmd
set incsearch
set laststatus=2
set autowrite
set number
set noshowmode

" tabs stuff
set sw=2
set tabstop=2
set expandtab

set splitbelow
set splitright

set path+=**
set wildmenu

"tab and space chars
set list
set listchars=eol:¬,tab:▸-

set cc=81

"reselect after indent
vnoremap > >gv
vnoremap < <gv

inoremap {<CR> {<CR>}<Esc>O

"escape works 'normally' in terminal mode, <leader>sh opens terminal in split
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>sh :terminal<CR>A
nnoremap <leader>spsh :sp <bar> :terminal<CR>A
nnoremap <leader>vssh :vs <bar> :terminal<CR>A

nnoremap Y y$

"commands for switching windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

"resize splits with arrow keys
nnoremap <Up>    :resize -2<CR>
nnoremap <Down>  :resize +2<CR>
nnoremap <Left>  :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

"text object for " as q
xnoremap iq i"
xnoremap aq a"
onoremap iq :normal vi"<CR>
onoremap aq :normal va"<CR>

"quickfix list mappings
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qb :cprev<CR>
nnoremap <silent><expr> <leader>qq "<cmd>".(get(getqflist({"winid": 1}), "winid") != 0? "cclose" : "botright copen")."<cr>"

augroup QuickFix
     au FileType qf nnoremap <buffer> dd :.Reject <CR>
     au FileType qf vnoremap <buffer> d :Reject <CR>
 augroup END
"easier use last macro mapping
nnoremap <leader>mm


" Completeopt for lsp, use <Tab> and <S-Tab> to navigate through popup menu
set completeopt=menu,menuone,noselect

"yank to system clipboard
vnoremap <leader>y "+y

"NERDTree stuff
nnoremap <leader>nn <cmd>NvimTreeToggle<CR>
nnoremap <leader>nf <cmd>NvimTreeFindFile<CR>

"bindings for telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope resume<cr>

:lua << EOF

require('telescope').setup {
  -- Other configurations
}


require('nvim-tree').setup{
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        git = false,
        folder_arrow = false,
      }
    }
  }
}


-- Setup lualine
require('lualine').setup {
    options = { 
        icons_enabled = false,
        theme = 'powerline',
        component_separators = {left = ' ', right = ' | '},
        section_separators = {left = ' ', right = ' '},
    },
    sections = {
      lualine_b = {{'filename', path = 1 }},
        lualine_c = {"b:lsp_names"}
    }
}

local nvim_lsp = require('lspconfig')
local configs = require('lspconfig.configs')

EOF
