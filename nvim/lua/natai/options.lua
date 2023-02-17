local indent = 2
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.fenc = 'utf-8'
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
opt.number = true
opt.termguicolors = true
opt.cursorline = true
opt.cursorcolumn = true
opt.visualbell = true
opt.showmatch = true
opt.wildmode = { 'list', 'longest' }

opt.laststatus = 3
opt.cmdheight = 0
opt.cmdwinheight = 10

opt.virtualedit = 'onemore'

opt.mouse = 'a'
opt.clipboard:append{ 'unnamed', 'unnamedplus' }

opt.pumblend=10
opt.winblend=30
opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}

vim.opt.guifont = { 'HackGen35 Console NF', 'h16', 'b' }
if vim.g.neovide then
  vim.g.neovide_cursor_vfx_mode = 'railgun'
  vim.g.neovide_transparency = 0.8
end

if vim.fn.has('win32') == 1 then
  vim.g.sqlite_clib_path = 'C:/lib/sqlite3.dll'
  vim.o.shell = 'pwsh.exe'
  vim.o.shellcmdflag = '-NoLogo -c'
  vim.o.shellquote = '"'
  vim.o.shellxquote = ''
end

vim.cmd[[
if system('uname -a | grep microsoft') != ''
  let g:clipboard = {
  \   'name': 'WslClipboard',
  \   'copy': {
  \      '+': 'clip.exe',
  \      '*': 'clip.exe',
  \    },
  \   'paste': {
  \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  \   },
  \   'cache_enabled': 0,
  \ }
endif
]]

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile'}, {
  pattern = '*.lang',
  command = 'set filetype=mclang',
})

