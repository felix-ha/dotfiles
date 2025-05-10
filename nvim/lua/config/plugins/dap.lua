
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")
      dap.configurations.python = {
      {
	type = 'python',
	request = 'launch',
	name = 'Start file - with third party code',
	program = "${file}",
	justMyCode = false,
      }
    }

      require("dapui").setup({
	    layouts = {
		-- {
		--   elements = {
		--     "scopes", -- Only include scopes/variables
		--   },
		--   size = 40,
		--   position = "left",
		-- },
		{
		  elements = {
		    "repl", -- Add REPL at the bottom
		  },
		  size = 15,
		  position = "bottom",
		},
	      },
      })
      require("nvim-dap-virtual-text").setup({
        commented = true, -- Show virtual text alongside comment
      })

      dap_python.setup(get_venv() .. '/bin/python')
      vim.keymap.set("n", "<leader>dv", function()
	  dapui.float_element("scopes", {
	    width = 120,
	    height = 50,
	    enter = true,
	    position = "center",
	    title = "Variables",
	  })
	end, { desc = "Debug: Show variables" })

      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "", -- or "❌"
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "", -- or "→"
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<leader>db", function()
      dap.toggle_breakpoint()
    end, vim.tbl_extend("force", opts, { desc = "Debug: Toggle breakpoint" }))

    vim.keymap.set("n", "<leader>dc", function()
      dap.continue()
    end, vim.tbl_extend("force", opts, { desc = "Debug: Continue" }))

    vim.keymap.set("n", "<leader>ds", function()
      local debug_config_index = 1
      require('dap').run(require('dap').configurations[vim.bo.filetype][debug_config_index])
    end, vim.tbl_extend("force", opts, { desc = "Debug: Start" }))

    vim.keymap.set("n", "<leader>do", function()
      dap.step_over()
    end, vim.tbl_extend("force", opts, { desc = "Debug: Step over" }))

    vim.keymap.set("n", "<leader>di", function()
      dap.step_into()
    end, vim.tbl_extend("force", opts, { desc = "Debug: Step into" }))

    vim.keymap.set("n", "<leader>dO", function()
      dap.step_out()
    end, vim.tbl_extend("force", opts, { desc = "Debug: Step out" }))

    vim.keymap.set("n", "<leader>dq", function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
	local config = vim.api.nvim_win_get_config(win)
	if config.relative ~= "" then -- This is a floating window
	  vim.api.nvim_win_close(win, true)
	end
      end
      dap.terminate()
      dapui.close()
    end, vim.tbl_extend("force", opts, { desc = "Debug: Quit debugging and close UI" }))

    vim.keymap.set("n", "<leader>du", function()
      dapui.toggle()
    end, vim.tbl_extend("force", opts, { desc = "Debug: Toggle UI" }))

	end,
  },
}

