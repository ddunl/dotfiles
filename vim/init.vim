set encoding=utf-8

call plug#begin()
	Plug 'preservim/nerdtree'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-commentary'

	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'	

	Plug 'itchyny/lightline.vim'
	Plug 'morhetz/gruvbox'

	Plug 'voldikss/vim-floaterm'
	Plug 'unblevable/quick-scope'

	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-compe'

	Plug 'ap/vim-css-color'
call plug#end()


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
set noexpandtab

set directory^=$HOME/.vim/swap//
set splitbelow
set splitright


set path+=**
set wildmenu
"tab and space chars
set list
set listchars=eol:¬,tab:▸-

set cc=100

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"reload vimrc
nnoremap <Leader>rel :source $MYVIMRC<CR>

"reselect after indenting
vnoremap > >gv 
vnoremap < <gv

"autocomplete brackets - still looking for more sublime-eqsue to beat this
inoremap {<CR> {<CR>}<Esc>O

"taken from blacksuan19 on github
function! RipgrepFzf(query, fullscreen)
	let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
	let initial_command = printf(command_fmt, shellescape(a:query))
	let reload_command = printf(command_fmt, '{q}')
	let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
	call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

let g:fzf_preview_window = ['right:50%', 'ctrl-/']


nnoremap <leader>test :call RipgrepFzf("test", 0)<CR>

"commands for open popup shell and run python in interactive mode
nnoremap <leader>sh :FloatermNew<CR>
nnoremap <leader>c :FloatermNew ./build.sh <CR>
autocmd filetype python nnoremap <buffer> <leader>b :FloatermNew python3 -i %<CR>

"compile tex on save
autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!

"open nerdtree if no file is opened with vim
autocmd VimEnter * if !argc() | NERDTree | endif

"easy exit insert mode in terminal
tnoremap <Esc> <C-\><C-n>


"commands for switching windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <Up>	 :resize -2<CR>
nnoremap <Down>  :resize +2<CR>
nnoremap <Left>  :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

nnoremap <leader>f :Files<CR>
nnoremap <leader>n :NERDTree<CR>
nnoremap <leader>g :Git 

nnoremap ciq ci"
nnoremap diq di"
nnoremap viq vi"

"yank to system clipboard
vnoremap <leader>y "+y
"opens gui file explorer at current dir
nnoremap <leader>o :call system("nohup nautilus . > /dev/null 2>&1 &") <CR>

nnoremap <leader>rt :retab! <CR>

"open term in new tab and enter insert mode
nnoremap <leader>tt :tabnew <BAR> term <CR> A

"run python webserver
nnoremap <leader>ws :tabnew <BAR> term <CR> A python3 -m http.server <CR> <Esc>

set cot=menuone,noinsert,noselect shm+=c


lua << EOF
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = false;

	source = {
		path = true;
		buffer = true;
		calc = true;
		vsnip = true;
		nvim_lsp = true;
		nvim_lua = true;
		spell = true;
		tags = true;
		snippets_nvim = true;
		treesitter = true;
	};
}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-p>"
	elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
		return t "<Plug>(vsnip-jump-prev)"
	else
		return t "<S-Tab>"
	end
end

vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF


" LSP config from chris@machine
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>



