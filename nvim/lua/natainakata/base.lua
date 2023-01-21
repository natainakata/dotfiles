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

vim.opt.cmdwinheight = 10

local cmdwin = vim.api.nvim_create_augroup("vimrc-cmdwin", { clear = true })
vim.api.nvim_create_autocmd({ 'CmdwinEnter' },
  {
    pattern = '*',
    callback = function ()
      vim.keymap.set('n', 'q', '<Cmd>quit<CR>', { buffer = true })
    end,
    group = cmdwin,
  }
)

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
else
  vim.opt.clipboard = 'unnamed'
  vim.cmd[[
    let g:clipboard = {
        \   'name': 'myClipboard',
        \   'copy': {
        \      '+': 'win32yank -i',
        \      '*': 'win32yank -i',
        \    },
        \   'paste': {
        \      '+': 'win32yank -o',
        \      '*': 'win32yank -o',
        \   },
        \   'cache_enabled': 1,
        \ }
  ]]
end

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile'}, {
  pattern = '*.lang',
  command = 'set filetype=mclang',
})
vim.g['fern#renderer'] = 'nerdfont'

vim.cmd[[
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'outputter/buffer/opener': 'new',
      \ 'outputter/buffer/into': 1,
      \ 'outputter/buffer/close_on_empty': 1,
      \ }
]]
