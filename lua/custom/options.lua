-- General editor options
vim.opt.clipboard = "unnamedplus"       -- Use system clipboard
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- Persistent undo
vim.opt.undofile = true
local undodir = vim.fn.expand("~/.config/nvim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

-- You can add more options here, e.g.:
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.g.mapleader = " "

