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

	local function get_just_recipes()
	 -- Get justfile recipes using 'just --list'
	 local handle = io.popen("just --list --unsorted")
	 if not handle then return {} end
	 local result = handle:read("*a")
	 handle:close()

	 local recipes = {}
	 for line in result:gmatch("[^\r\n]+") do
	   -- Extract recipe name before any @ or # symbols
	   local recipe = line:match("^([^@#]+)")
	   if recipe then
	     table.insert(recipes, {
	       name = "just " .. recipe:gsub("%s+$", ""),
	       cmd = "just " .. recipe:gsub("%s+$", "")
	     })
	   end
	 end
	 return recipes
	end

	local function custom_commands()
	local commands = get_just_recipes()
 	table.insert(commands, { name = "Run pytest", cmd = "pytest ." })
 	table.insert(commands, { name = "Git log", cmd = "git log -n 10 --graph --abbrev-commit --decorate" })
	    -- { name = "Start server", cmd = "npm start" },
	    -- Add your commands
	  -- }
	  local pickers = require("telescope.pickers")
	  local finders = require("telescope.finders")
	  local conf = require("telescope.config").values
	  local actions = require("telescope.actions")
	  local action_state = require("telescope.actions.state")
          local previewers = require("telescope.previewers")
	  pickers.new({}, {
	    prompt_title = "Commands",
            previewer = previewers.new_buffer_previewer({
	     title = "Command Preview",
	     define_preview = function(self, entry)
	       vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
	 	"Command: " .. entry.value.cmd,
	 	"",
	       })
	     end,
	    }),
	    finder = finders.new_table({
	      results = commands,
	      entry_maker = function(entry)
		return {
		  value = entry,
		  display = entry.name,
		  ordinal = entry.name,
		}
	      end,
	    }),
	    attach_mappings = function(prompt_bufnr)
	      actions.select_default:replace(function()
		local selection = action_state.get_selected_entry()
		actions.close(prompt_bufnr)
		vim.cmd(string.format("TermExec cmd='%s' direction=float", selection.value.cmd))
	      end)
	      return true
	    end,
	    sorter = conf.generic_sorter({}),
	  }):find()
	end

	vim.keymap.set('n', '<leader>fj', custom_commands, { desc = "Find just recipes" })
	vim.keymap.set("n", "<Leader>ff", require('telescope.builtin').find_files, { desc = "Find files" })
	-- see multigrep
	-- vim.keymap.set("n", "<Leader>fg", require('telescope.builtin').live_grep, { desc = "Live grep" })
	vim.keymap.set("n", "<Leader>fh", require('telescope.builtin').help_tags, { desc = "Search help tags" })
	vim.keymap.set("n", "<Leader>fc", function()
	  require('telescope.builtin').find_files {
	    cwd = vim.fn.stdpath("config")
	  }
	end, { desc = "Find in config directory" })
	vim.keymap.set("n", "<Leader>fp", function()
	  require('telescope.builtin').find_files {
	    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
	  }
	end, { desc = "Find in plugins directory" })

	vim.keymap.set('n', '<Leader>fk', '<cmd>Telescope keymaps<cr>', { desc = "Find keymaps" })
	vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })

      require "config.telescope.multigrep".setup()
    end
  }
}
