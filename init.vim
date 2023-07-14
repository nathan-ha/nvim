" Reminders when first using this on new device:
" 	run :PlugInstall
" 	install	new languages using :TSInstall

lua << EOF
	vim.loader.enable() -- speeds up startup
EOF
" vim-plug plugins
call plug#begin('~\AppData\Local\nvim\plugged')
 	Plug 'lukas-reineke/indent-blankline.nvim' " colored indentation lines
 	Plug 'folke/tokyonight.nvim' " tokyo night theme
 	Plug 'windwp/nvim-autopairs' " autocompletes brackets and stuff
 	Plug 'nvim-lua/plenary.nvim'
 	Plug 'nvim-treesitter/nvim-treesitter' " helps syntax highlighting	
	Plug 'windwp/nvim-ts-autotag' " autocompletes html tags
	Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' } " measures startup time
	Plug 'numToStr/Comment.nvim' " better commenting (gc to toggle line comment, gb for block)
 	" the next 6 plugins are for autocompletion
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
	require('Comment').setup()
 	require('nvim-treesitter.configs').setup {
 	  		highlight = { enable = true }
 	} 

	-- sets up autocomplete
	local cmp = require'cmp'
	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' }, -- For vsnip users.
			-- { name = 'luasnip' }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = 'buffer' },
		})
	})


	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' }, -- For vsnip users.
			-- { name = 'luasnip' }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = 'buffer' },
		})
	})

	cmp.setup.cmdline({ '/', '?' }, {
	  mapping = cmp.mapping.preset.cmdline(),
	  sources = {
	    { name = 'buffer' }
	  }
	})
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
" set backspace=2	" set backspace key to work like most other editors
set scrolloff=5	" keep at least 5 lines above/below
set hlsearch	" highlight the search
" set clipboard=unnamed " copy and paste from clipboard
set noswapfile
set termguicolors " fixes colors or something
set shiftwidth=4 "need this to prevent double-indents on tab
set shell=powershell " using powershell instead of cmd
tnoremap <Esc> <C-\><C-n> " lets you enter normal mode in the terminal with escape
colorscheme tokyonight-storm

" keeps cursor in same place
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif
