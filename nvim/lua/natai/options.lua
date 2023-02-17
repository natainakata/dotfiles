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
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.visualbell = true
vim.opt.showmatch = true
vim.opt.wildmode = { 'list', 'longest' }

vim.opt.laststatus = 3
vim.opt.cmdheight = 1
vim.opt.cmdwinheight = 10

vim.opt.virtualedit = 'onemore'

vim.opt.mouse = 'a'
vim.opt.clipboard:append{ 'unnamed', 'unnamedplus' }

vim.opt.pumblend=10
vim.opt.winblend=30
vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}

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

