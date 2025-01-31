vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>") -- run whole file
vim.keymap.set("n", "<space>x", ":.lua<CR>") -- run line
vim.keymap.set("v", "<space>x", ":lua<CR>") -- run selection

-- ToggleTerm --
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=float dir=git_dir<cr>", { desc="Toggle [t]erminal" })

local opts = { noremap = true, silent = true }
vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
vim.keymap.set("n", "<leader>Tl", "<cmd>ToggleTermSendCurrentLine<cr>", opts)
vim.keymap.set("v", "<leader>Tv", "<cmd>ToggleTermSendVisualLines<cr>", opts)
vim.keymap.set("v", "<leader>TV", "<cmd>ToggleTermSendVisualSelection<cr>", opts)

terminal_cmd = os.getenv("TERMINAL_CMD") or "ls -lisah"
vim.keymap.set("n", "<F5>", string.format("<cmd>TermExec cmd='%s' direction=float<cr>", terminal_cmd), opts)

-- oil
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", opts)


-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg='#FF0000', bold = true })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg='#FFFF00' })
