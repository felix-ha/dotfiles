return {

    {
        "catppuccin/nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,
        flavour = "mocha", -- make sure to load this before all the other start plugins
        config = function()
          -- load the colorscheme here
          vim.cmd([[colorscheme catppuccin]])
        end,
      },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = {
            {'nvim-lua/plenary.nvim'},
        }
    },

}