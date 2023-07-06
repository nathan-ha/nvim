-- vim plug plugins
vim.cmd([[
call plug#begin('~\AppData\Local\nvim\plugged')

		Plug 'preservim/nerdtree' " file tree
		Plug 'lukas-reineke/indent-blankline.nvim' " indentation lines
		Plug 'folke/tokyonight.nvim' " tokyo night theme
		Plug 'windwp/nvim-autopairs'

call plug#end()
]])

require("nvim-autopairs").setup()
require("tokyonight").setup() 

-- vim settings
vim.cmd([[
syn on	" turn on syntax highlighting
set tabstop=4	" set tab width
set nu	" show line numbers to left of text
set ruler	" show row, col in lower-right corner
set ignorecase	" case-insensitive search (/ and ?)
set nocompatible	" vim-specific mode
set backspace=2	" set backspace key to work like most other editors
set scrolloff=5	" keep at least 5 lines above/below
set hlsearch	" highlight the search
set clipboard=unnamed " copy and paste from clipboard
set termguicolors
set noswapfile
colorscheme tokyonight

" keeps cursor in same place
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

]])


