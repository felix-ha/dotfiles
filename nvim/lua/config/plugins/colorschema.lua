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


    { 
    'Mofiqul/vscode.nvim',
    priority = 1000, 
    init = function()
      vim.cmd.colorscheme 'vscode'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

}
