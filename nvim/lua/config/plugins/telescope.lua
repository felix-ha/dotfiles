return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
        {  'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        }
    },
    config = function()
	-- run :Telescope builtin to see all commands
	-- run :checkhealth telescope
      require('telescope').setup {  
		--  pickers = {  
		--      find_files = {  
		--   theme = "ivy",
		-- },
		--      live_grep = {  
		--   theme = "ivy",
		-- },
		--  },
		--  extensions = {  
		-- fzf = {},
		--  }
        }

	require('telescope').load_extension('fzf')


      vim.keymap.set("n", "<Leader>ff", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<Leader>fg", require('telescope.builtin').live_grep)
      vim.keymap.set("n", "<Leader>fh", require('telescope.builtin').help_tags)
      vim.keymap.set("n", "<Leader>fc", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
      vim.keymap.set("n", "<Leader>fp", function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end)

      -- TODO lsp
      vim.keymap.set("n", "<space>fr", require('telescope.builtin').lsp_references)

      require "config.telescope.multigrep".setup()
    end
  }
}
