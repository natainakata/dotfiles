vim.cmd[[autocmd!]]

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

vim.opt.virtualedit = 'onemore'

vim.opt.mouse = 'a'

vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.pumblend=10
vim.opt.winblend=30
vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}

if vim.fn.has('win32') == 1 then
  vim.g.sqlite_clib_path = 'C:/lib/sqlite3.dll'
  vim.o.shell = 'pwsh.exe'
  vim.o.shellcmdflag = '-NoLogo -c'
  vim.o.shellquote = '"'
  vim.o.shellxquote = ''
end

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile'}, {
  pattern = '*.lang',
  command = 'set filetype=mclang',
})

