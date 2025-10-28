# to use different config, for example:  alias v="NVIM_APPNAME=custom nvim"

local f5 = "ls -a"

_G.get_venv = function()
    return ".venv"
end

-- _G.get_poetry_venv = function()
--     local handle = io.popen('poetry env info --path 2>/dev/null')
--     if handle then
--         local result = handle:read("*a")
--         handle:close()
--         return result:gsub("^%s*(.-)%s*$", "%1")
--     end
--     return nil
-- end

-- local function activate_poetry_venv()
--     -- local venv = get_poetry_venv()
--     local venv = ".venv"
--     if venv then
--         vim.g.python3_host_prog = venv .. '/bin/python'
--         require('toggleterm').setup({
--             on_open = function(term)
--                 if not term.venv_activated then
--                     local venv_activate = venv .. '/bin/activate'
--                     term:send('source ' .. venv_activate .. '\n')
--                     term.venv_activated = true
--                 end
--             end
--         })
--     end
-- end

-- activate_poetry_venv()

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>") -- run whole file
vim.keymap.set("n", "<space>x", ":.lua<CR>") -- run line
vim.keymap.set("v", "<space>x", ":lua<CR>") -- run selection

vim.keymap.set("n", "<leader>v", "<cmd>:vsplit<cr>", { desc="Vertical split" })
vim.keymap.set("n", "<leader>h", "<cmd>:split<cr>", { desc="Horizontal split" })

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc="Toggle ZenMode" })

local harpoon_utils = require("custom.harpoon_utils")

local opts = { noremap = true, silent = true }

local function with_opts(additional_opts)
    return vim.tbl_extend("force", opts, additional_opts or {})
end

vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
vim.keymap.set("n", "<leader>Tl", "<cmd>ToggleTermSendCurrentLine<cr>",
    with_opts({ desc = "Send current line to terminal" }))
vim.keymap.set("v", "<leader>Tv", "<cmd>ToggleTermSendVisualLines<cr>",
    with_opts({ desc = "Send visual lines to terminal" }))
vim.keymap.set("v", "<leader>TV", "<cmd>ToggleTermSendVisualSelection<cr>",
    with_opts({ desc = "Send visual selection to terminal" }))


vim.keymap.set({ 'n', 'v' }, "<leader>gc", ":Gen Chat<CR>",
    with_opts({ desc = "Gen Chat - continues chat or starts plain conversation." }))

vim.keymap.set({ 'n', 'v' }, "<leader>ga", ":Gen Ask<CR>",
    with_opts({ desc = "Gen Ask - with context" }))

vim.keymap.set({ 'n', 'v' }, "<leader>gr", ":Gen Review_Code<CR>",
    with_opts({ desc = "Gen Review Code" }))

vim.keymap.set({ 'n', 'v' }, "<leader>gt", ":Gen Write_Tests<CR>",
    with_opts({ desc = "Gen Write_Tests" }))

vim.keymap.set({ 'n', 'v' }, "<leader>ge", ":Gen Enhance_Code<CR>",
    with_opts({ desc = "Gen Enhance Code - replace" }))

vim.keymap.set({ 'n', 'v' }, "<leader>gf", ":Gen Change_Code<CR>",
    with_opts({ desc = "Gen Change_Code - fix code - replace" }))

vim.keymap.set({ 'n', 'v' }, "<leader>gy", ":Gen Ask_Yanked<CR>",
    with_opts({ desc = "Gen Ask_Yanked" }))

vim.api.nvim_create_user_command("GenHarpoon", function()
  harpoon_utils.yank_harpoon_files()
  vim.cmd("Gen Ask_Harpoon")
end, {})

vim.keymap.set('n', '<leader>gh', "<cmd>GenHarpoon<CR>", { desc = "Generate from Harpoon files" })

--
-- vim.keymap.set("n", "<F1>",
--     string.format("<cmd>TermExec cmd='%s' direction=float<cr>", "source $HOME/venvs/py311/bin/activate"),
--     with_opts({ desc = "Active poetry py311 venv" })
-- )

-- local terminal_cmd = os.getenv("TERMINAL_CMD") or "ls -lisah"
-- vim.keymap.set("n", "<F5>",
--     string.format("<cmd>TermExec cmd='%s' direction=float<cr>", terminal_cmd),
--     with_opts({ desc = "Execute TERMINAL_CMD" })
-- )
--
vim.keymap.set("n", "<F5>",
    string.format("<cmd>TermExec cmd='%s' direction=float<cr>", f5),
    with_opts({ desc = f5 })
)

-- ToggleTerm --
vim.keymap.set("n", "<leader>t", "<cmd>1ToggleTerm direction=float dir=git_dir<cr>", { desc="Toggle [t]erminal" })

local Terminal = require("toggleterm.terminal").Terminal
local term1

local function get_term1()
  if term1 then return term1 end
  term1 = Terminal:new({
    id = 1,
    direction = "float",
    close_on_exit = false,
    cmd = vim.env.SHELL or "bash",
  })
  return term1
end

vim.keymap.set("n", "<Leader>e", function()
  local file_path = vim.fn.expand("%:p")
  if file_path == "" then
    vim.notify("Error: No file name. Save the buffer first.", vim.log.levels.ERROR)
    return
  end
  if vim.fn.expand("%:e") ~= "hs" then
    vim.notify("Not a Haskell file (.hs)", vim.log.levels.WARN)
    return
  end

  local term = get_term1()
  term:open()

  local cmd = "/root/.ghcup/bin/runghc " .. vim.fn.shellescape(file_path)
  term:send(cmd)
end, { desc = "Run current Haskell file in terminal" })

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

