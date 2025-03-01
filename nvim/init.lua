_G.get_poetry_venv = function()
    local handle = io.popen('poetry env info --path 2>/dev/null')
    if handle then
        local result = handle:read("*a")
        handle:close()
        return result:gsub("^%s*(.-)%s*$", "%1")
    end
    return nil
end

local function activate_poetry_venv()
    local venv = get_poetry_venv()
    if venv then
        vim.g.python3_host_prog = venv .. '/bin/python'
        require('toggleterm').setup({
            on_open = function(term)
                if not term.venv_activated then
                    local venv_activate = venv .. '/bin/activate'
                    term:send('source ' .. venv_activate .. '\n')
                    term.venv_activated = true
                end
            end
        })
    end
end


vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

activate_poetry_venv()

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"

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

-- ToggleTerm --
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=float dir=git_dir<cr>", { desc="Toggle [t]erminal" })

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

vim.keymap.set({ 'n', 'v' }, "<leader>G", ":Gen<CR>",
    with_opts({ desc = "Gen" }))

vim.keymap.set({ 'n', 'v' }, "<leader>C", ":Gen Chat<CR>",
    with_opts({ desc = "Gen Chat" }))

-- local terminal_cmd = os.getenv("TERMINAL_CMD") or "ls -lisah"
-- vim.keymap.set("n", "<F5>",
--     string.format("<cmd>TermExec cmd='%s' direction=float<cr>", terminal_cmd),
--     with_opts({ desc = "Execute TERMINAL_CMD" })
-- )
--
--
vim.keymap.set("n", "<F1>",
    string.format("<cmd>TermExec cmd='%s' direction=float<cr>", "source $HOME/venvs/py311/bin/activate"),
    with_opts({ desc = "Active poetry py311 venv" })
)

vim.keymap.set("n", "<F5>",
    string.format("<cmd>TermExec cmd='%s' direction=float<cr>", "pytest tests/services/test_topic_service.py"),
    with_opts({ desc = "Run test" })
)

vim.keymap.set("n", "<Leader>e",
    string.format("<cmd>TermExec cmd='%s' direction=float<cr>", "pytest tests/data_collection/test_labelstudio.py"),
    with_opts({ desc = "Execute command" })
)

vim.keymap.set("n", "<Leader>dc", function()
    require("dap").continue()
end, { desc = "Debug: Continue execution" })

vim.keymap.set("n", "<F9>", function()
    require("dap").continue()
end)

vim.keymap.set("n", "<Leader>do", function()
    require("dap").step_over()
end, { desc = "Debug: Step over current line" })

vim.keymap.set("n", "<Leader>di", function()
    require("dap").step_into()
end, { desc = "Debug: Step into function call" })

vim.keymap.set("n", "<Leader>du", function()
    require("dap").step_out()
end, { desc = "Debug: Step out of current function" })

vim.keymap.set("n", "<Leader>b", function()
    require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint at line" })

vim.keymap.set("n", "<Leader>B", function()
    require("dap").set_breakpoint()
end, { desc = "Set breakpoint with condition" })

vim.keymap.set("n", "<Leader>dr", function()
    require("dap").repl.open()
end, { desc = "Debug: Open REPL" })


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
