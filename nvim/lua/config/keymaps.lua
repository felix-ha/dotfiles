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

-- ToggleTerm --
keymap("n", "<leader>tt", "<cmd>ToggleTerm<cr>", opts)
keymap("n", "<leader>ttf", "<cmd>ToggleTerm direction=float<cr>", opts)
keymap("n", "<C-_>", "<cmd>ToggleTerm direction=float<cr>", opts)
keymap("t", "jk", [[<C-\><C-n>]], opts)

-- Telescope --
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)

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

