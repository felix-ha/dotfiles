   return   {

	-- {
	--   "rockyzhang24/arctic.nvim",
	--   branch = "v2",
	--   dependencies = { "rktjmp/lush.nvim" },
	-- priority = 1000, -- Make sure to load this before all the other start plugins.
	-- init = function()
	--   vim.cmd.colorscheme 'arctic'
	--   -- You can configure highlights by doing something like:
	--   vim.cmd.hi 'Comment gui=none'
	-- end,
	-- },
	-- {
	--   'projekt0n/github-nvim-theme',
	--   name = 'github-theme',
	--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--   priority = 1000, -- make sure to load this before all the other start plugins
	--   config = function()
	--     require('github-theme').setup({
	--       -- ...
	--     })
	--
	--     vim.cmd('colorscheme github_dark_default')
	--   end,
	-- }

  --  { 
  --  'briones-gabriel/darcula-solid.nvim',
  --   dependencies = { "rktjmp/lush.nvim" },
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     vim.cmd.colorscheme 'darcula-solid'
  --     -- You can configure highlights by doing something like:
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },


  --   {
  --   'Mofiqul/vscode.nvim',
  --   priority = 1000, 
  --   init = function()
  --     vim.cmd.colorscheme 'vscode'
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },

-- {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--     init = function()
--       vim.cmd.colorscheme 'tokyonight-night'
--       vim.cmd.hi 'Comment gui=none'
--     end,
-- },
	--  {
	--    "rktjmp/lush.nvim",
	--    priority = 1000  -- Higher priority to ensure it loads first
	--  },
	--    {
	--      "briones-gabriel/darcula-solid.nvim",
	--      lazy = false,
	--      priority = 100,
	--      opts = {},
	-- config = function()
	--   vim.cmd.colorscheme 'darcula-solid'
	--   vim.cmd.hi 'Comment gui=none'
	-- end,
	--    dependencies = { "rktjmp/lush.nvim" },
	--    },

{
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  opts = {},
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
      vim.cmd.hi 'Comment gui=none'
    end,
},


}
