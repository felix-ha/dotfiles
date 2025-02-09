return{
    {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dap.defaults.fallback.force_external_terminal = false
    dap.set_log_level('TRACE')
    require("dapui").setup()
    require("dap-python").setup(get_poetry_venv() .. '/bin/python') -- install debugpy into venv
    dap.configurations.python = {
      {
        justMyCode = false,
        type = "python",
        request = "launch",
        module = "pytest",
        -- program = "${file}",
        name = "launch file",
	args = {"-s", "-v"},
	pythonPath = function()
	     return get_poetry_venv() .. '/bin/python'
        end,
	console = 'integratedTerminal',
	stopOnEntry = false,
	showReturnValue = true,
	redirectOutput = true,
	subProcess = true,
	-- needed to stop at breakpoints
	-- env = {
	--   PYDEVD_DISABLE_FILE_VALIDATION = "1"
	-- },
	-- args = {"-Xfrozen_modules=off"}
      },
    }
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
 },
}
