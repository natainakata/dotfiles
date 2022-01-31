local util = require('utils')

local indent = 2

vim.opt.fenc = 'utf-8'
vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.wrapscan = true

vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.visualbell = true
vim.opt.showmatch = true
vim.opt.wildmode = { 'list', 'longest' }

vim.opt.virtualedit = 'onemore'

vim.opt.mouse = 'a'

if (not vim.g.vscode) then
  vim.cmd('colorscheme base16-' .. vim.env.BASE16_THEME)
end
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.pumblend=10
vim.opt.winblend=30

