-- :help lsp
-- :help lspconfi- search for your language
-- follow install instructions
--
-- lua
-- https://luals.github.io/#neovim-install
-- brew install lua-language-server
--
--
-- :help ins-completion
-- ctrl x + ctrl o
 return {
     {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
	  library = {
	    -- See the configuration section for more details
	    -- Load luvit types when the `vim.uv` word is found
	    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
	  },
	},
    },
    config = function()
	local capabilities = require('blink.cmp').get_lsp_capabilities()
        require("lspconfig").lua_ls.setup { capabilities = capabilities}

	-- python with hardcodec venv
        -- local home = os.getenv("HOME")
        -- local venv_path = home .. "/Library/Caches/pypoetry/virtualenvs/rag-agent-HJ9hKCx6-py3.11"
        -- require("lspconfig").pyright.setup {
        --   cmd = { venv_path .. "/bin/pyright-langserver", "--stdio" },
        --   settings = {
        --     python = {
        --       venvPath = venv_path,
        --       pythonPath = venv_path .. "/bin/python"
        --     }
        --   }
        -- }
	--
	--python with venv calling directory with poetry
       -- local function get_poetry_venv()
       --      -- Run poetry env info --path and capture output
       --      local handle = io.popen('poetry env info --path 2>/dev/null')
       --      if handle then
       --          local result = handle:read("*a")
       --          handle:close()
       --          -- Remove trailing whitespace/newline
       --          return result:gsub("^%s*(.-)%s*$", "%1")
       --      end
       --      return nil
       --  end
       --
	require("lspconfig").pyright.setup {
	on_attach = function(_, bufnr)
         local opts = { buffer = bufnr, silent = true, noremap = true }

	 vim.keymap.set('n', 'gr', function()
		require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown({}))
	    end, vim.tbl_extend('force', opts, { desc = "Find references" }))

	 vim.keymap.set("n", "<space>fr", require('telescope.builtin').lsp_references, vim.tbl_extend('force', opts, { desc = "Find references (telescope duplicate)" }))

	 vim.keymap.set('n', 'gd', function()
		require('telescope.builtin').lsp_definitions(require('telescope.themes').get_dropdown({}))
	    end, vim.tbl_extend('force', opts, { desc = "Go to definition" }))

        vim.keymap.set('n', 'gD', function()
            require('telescope.builtin').lsp_type_definitions(require('telescope.themes').get_dropdown({}))
        end, vim.tbl_extend('force', opts, { desc = "Go to type definition" }))

	 vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = "Hover" }))

	 vim.keymap.set('n', 'gC', function()
		require('telescope.builtin').lsp_incoming_calls(require('telescope.themes').get_dropdown({}))
	    end, vim.tbl_extend('force', opts, { desc = "List all call sites" }))

	vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = "Rename symbol" }))

	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = "Code actions" }))


	end,
          on_new_config = function(new_config)
              local venv_path = get_venv()
              if venv_path then
                  new_config.cmd = { venv_path .. "/bin/pyright-langserver", "--stdio" }
                  new_config.settings = {
                      python = {
                          venvPath = venv_path,
                          pythonPath = venv_path .. "/bin/python"
                      }
                  }
              end
          end,
        }
    end,

     }

 }

