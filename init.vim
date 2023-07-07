" -- vim plug plugins
call plug#begin('~\AppData\Local\nvim\plugged')
		Plug 'preservim/nerdtree' " file tree
		Plug 'lukas-reineke/indent-blankline.nvim' " colored indentation lines
		Plug 'folke/tokyonight.nvim' " tokyo night theme
		Plug 'windwp/nvim-autopairs' " autocompletes brackets and stuff
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' } " file searcher
		Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " helps syntax highlighting	
		Plug 'windwp/nvim-ts-autotag' " autocompletes html tags
		Plug 'L3MON4D3/LuaSnip', {'tag': 'v<CurrentMajor>.*', 'do': 'make install_jsregexp'} " Replace <CurrentMajor> by the latest released major (first number of latest release)
		" the next 6 are for autocompletion
		Plug 'neovim/nvim-lspconfig'
		Plug 'hrsh7th/cmp-nvim-lsp'
		Plug 'hrsh7th/cmp-buffer'
		Plug 'hrsh7th/cmp-path'
		Plug 'hrsh7th/cmp-cmdline'
		Plug 'hrsh7th/nvim-cmp'
call plug#end()

" lua commands
lua << EOF
		require("nvim-autopairs").setup()
		require("nvim-ts-autotag").setup()

		require('nvim-treesitter.configs').setup {
				ensure_installed = { "lua", "vim", "cpp", "html", "javascript", "python" },
		  		highlight = { enable = true },
		} 
		  -- setting up auto complete
		  -- Set up nvim-cmp.
		  local cmp = require'cmp'
		  cmp.setup({
		    snippet = {
		      -- REQUIRED - you must specify a snippet engine
		      expand = function(args)
		        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
		      -- { name = 'vsnip' }, -- For vsnip users.
		      -- { name = 'luasnip' }, -- For luasnip users.
		      -- { name = 'ultisnips' }, -- For ultisnips users.
		      -- { name = 'snippy' }, -- For snippy users.
		    }, {
		      { name = 'buffer' },
		    })
		  })
		  -- Set configuration for specific filetype.
		  cmp.setup.filetype('gitcommit', {
		    sources = cmp.config.sources({
		      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
		    }, {
		      { name = 'buffer' },
		    })
		  })
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
		  -- Set up lspconfig.
		  local capabilities = require('cmp_nvim_lsp').default_capabilities()
		  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
		  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
		  --   capabilities = capabilities
		  -- }

		require("tokyonight").setup({
		  -- your configuration comes here
		  -- or leave it empty to use the default settings
		  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
		  light_style = "day", -- The theme is used when the background is set to light
		  transparent = false, -- Enable this to disable setting the background color
		  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
		  styles = {
		    -- Style to be applied to different syntax groups
		    -- Value is any valid attr-list value for `:help nvim_set_hl`
		    comments = { italic = true },
		    keywords = { italic = true },
		    functions = {},
		    variables = {},
		    -- Background styles. Can be "dark", "transparent" or "normal"
		    sidebars = "dark", -- style for sidebars, see below
		    floats = "dark", -- style for floating windows
		  },
		  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
		  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
		  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
		  dim_inactive = false, -- dims inactive windows
		  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
		  --- You can override specific color groups to use other groups or a hex color
		  --- function will be called with a ColorScheme table
		  ---@param colors ColorScheme
		  on_colors = function(colors) end,
		  --- You can override specific highlights to use other groups or a hex color
		  --- function will be called with a Highlights and ColorScheme table
		  ---@param highlights Highlights
		  ---@param colors ColorScheme
		  on_highlights = function(highlights, colors) end,
		})
EOF

" -- vim settings
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
set noswapfile
set termguicolors
colorscheme tokyonight-storm

" keeps cursor in same place
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

