return {

    {
        "EdenEast/nightfox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,
        config = function()
          -- load the colorscheme here
        vim.o.background = "dark" -- or "light" for light mode
		vim.cmd([[colorscheme terafox]]) 
        end,
      },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },

    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = {
            {'nvim-lua/plenary.nvim'},
        }
    },

    {
        'goolord/alpha-nvim',
    },

    {
    	-- Cmp 
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path",  -- path completions
   "saadparwaiz1/cmp_luasnip", -- snippet completions
   "hrsh7th/cmp-nvim-lsp", 
	"hrsh7th/cmp-nvim-lua",
	-- Snippets
  "L3MON4D3/LuaSnip",  --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use
  lazy = false
    }

}
