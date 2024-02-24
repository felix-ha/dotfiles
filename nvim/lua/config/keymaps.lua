-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap


-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- ZenMode --
keymap("n", "<leader>z", "<cmd>ZenMode<cr>", opts)

-- ToggleTerm --
keymap("n", "<leader>ttf", "<cmd>ToggleTerm direction=float dir=git_dir<cr>", opts)
keymap("n", "<leader>tth", "<cmd>ToggleTerm direction=horizontal dir=git_dir<cr>", opts)
keymap("n", "<leader>ttv", "<cmd>ToggleTerm direction=vertical dir=git_dir<cr>", opts)
keymap("n", "<C-_>", "<cmd>ToggleTerm direction=float dir=git_dir<cr>", opts)
keymap("t", "jk", [[<C-\><C-n>]], opts)
keymap("n", "<leader>ttl", "<cmd>ToggleTermSendCurrentLine<cr>", opts)
keymap("v", "<leader>ttv", "<cmd>ToggleTermSendVisualLines<cr>", opts)
keymap("v", "<leader>ttV", "<cmd>ToggleTermSendVisualSelection<cr>", opts)
terminal_cmd = os.getenv("TERMINAL_CMD") or "ls -lisah"
keymap("n", "<F5>", string.format("<cmd>TermExec cmd='%s' direction=float<cr>", terminal_cmd), opts)

-- Telescope --
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)

-- Navbuddy --
keymap("n", "<leader>n", "<cmd>Navbuddy<cr>", opts)

-- debugging --
vim.keymap.set("n", "<Leader>dc", function()
  require("dap").continue()
end)
vim.keymap.set("n", "<Leader>do", function()
  require("dap").step_over()
end)
vim.keymap.set("n", "<Leader>di", function()
  require("dap").step_into()
end)
vim.keymap.set("n", "<Leader>du", function()
  require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>b", function()
  require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>B", function()
  require("dap").set_breakpoint()
end)
vim.keymap.set("n", "<Leader>dr", function()
  require("dap").repl.open()
end)

