local util = require('utils')

local indent = 2

util.opt.fenc = 'utf-8'
util.opt.backup = false
util.opt.swapfile = false

util.opt.expandtab = true
util.opt.smartindent = true
util.opt.tabstop = indent
util.opt.shiftwidth = indent

util.opt.hlsearch = true
util.opt.incsearch = true
util.opt.smartcase = true
util.opt.wrapscan = true

util.opt.number = true
util.opt.termguicolors = true
util.opt.cursorline = true
util.opt.cursorcolumn = true
util.opt.visualbell = true
util.opt.showmatch = true
util.opt.wildmode = { 'list', 'longest' }

util.opt.virtualedit = 'onemore'

util.opt.mouse = 'a'

vim.cmd('colorscheme base16-' .. vim.env.BASE16_THEME)
util.opt.clipboard:append { 'unnamedplus' }
util.opt.pumblend=10
util.opt.winblend=30
util.g.minimap_auto_start = 1
util.g.minimap_auto_start_win_enter = 1

