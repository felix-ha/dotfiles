local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.number = true
opt.mouse = "a"
opt.termguicolors = true
opt.tabstop = 4
opt.fileencoding = "utf-8"
opt.splitbelow = true
opt.splitright = true
opt.cursorline = true

vim.cmd [[set iskeyword+=-]]
