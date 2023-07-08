lua << EOF
	vim.loader.enable() -- speeds up startup
EOF

" vim-plug plugins
call plug#begin('~\AppData\Local\nvim\plugged')
 		Plug 'lukas-reineke/indent-blankline.nvim' " colored indentation lines
 		Plug 'folke/tokyonight.nvim' " tokyo night theme
 		Plug 'windwp/nvim-autopairs' " autocompletes brackets and stuff
 		Plug 'nvim-lua/plenary.nvim'
 		Plug 'nvim-treesitter/nvim-treesitter' "  helps syntax highlighting	
 		Plug 'windwp/nvim-ts-autotag' " autocompletes html tags
		Plug 'dstein64/vim-startuptime'
		Plug 'lambdalisue/fern.vim', { 'on': 'Fern .' } " file tree explorer
		Plug 'nathom/filetype.nvim' " replaces some file for faster loading
 		" the next 6 are for autocompletion
 		Plug 'neovim/nvim-lspconfig'
 		Plug 'hrsh7th/cmp-nvim-lsp'
 		Plug 'hrsh7th/cmp-buffer'
 		Plug 'hrsh7th/cmp-path'
 		Plug 'hrsh7th/cmp-cmdline'
 		Plug 'hrsh7th/nvim-cmp'
call plug#end()
 
 " lua code
lua << EOF
 		require("nvim-autopairs").setup()
 		require("nvim-ts-autotag").setup()
 		require('nvim-treesitter.configs').setup {
 		  		highlight = { enable = true }
 		} 

		-- sets up autocomplete
		local cmp = require'cmp'
		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
		  mapping = cmp.mapping.preset.cmdline(),
		  sources = {
		    { name = 'buffer' }
		  }
		})
		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
		  mapping = cmp.mapping.preset.cmdline(),
		  sources = cmp.config.sources({
		    { name = 'path' }
		  }, {
		    { name = 'cmdline' }
		  })
		})
EOF
 
" vim settings
syn on	" turn on syntax highlighting
set tabstop=4	" set tab width
set nu	" show line numbers to left of text
set ruler	" show row, col in lower-right corner
set ignorecase	" case-insensitive search (/ and ?)
set nocompatible	" vim-specific mode
set backspace=2	" set backspace key to work like most other editors
set scrolloff=5	" keep at least 5 lines above/below
set hlsearch	" highlight the search
" set clipboard=unnamed " copy and paste from clipboard
set noswapfile
set termguicolors
colorscheme tokyonight-storm

" keeps cursor in same place
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif


