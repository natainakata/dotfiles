local indent = 2
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.fenc = "utf-8"
opt.backup = false
opt.swapfile = false

opt.expandtab = true
opt.smartindent = true
opt.tabstop = indent
opt.shiftwidth = indent

opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true
opt.wrapscan = true


opt.virtualedit = "onemore"
opt.clipboard:append({ "unnamed", "unnamedplus" })

opt.list = true
