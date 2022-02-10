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

vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.visualbell = true
vim.opt.showmatch = true
vim.opt.wildmode = { 'list', 'longest' }

vim.opt.virtualedit = 'onemore'

vim.opt.mouse = 'a'

vim.cmd[[
colorscheme dracula
]]
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.pumblend=10
vim.opt.winblend=30

vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_shortcut = {
  ['last_session']       = 'SPC s l',
  ['find_history']       = 'SPC f o',
  ['find_file']          = 'SPC f f',
  ['new_file']           = 'SPC c n',
  ['change_colorscheme'] = 'SPC t c',
  ['find_word']          = 'SPC f a',
  ['book_marks']         = 'SPC f b',
}

vim.cmd[[
let g:dps_dial#augends = [
  \ 'decimal',
  \ 'date-slash',
  \ {'kind': 'constant', 'opts': {'elements': ['true', 'false']}},
  \ {'kind': 'case', 'opts': {'cases': ['camelCase', 'snake_case'], 'cyclic': v:true}}
  \]
]]

require('which-key').setup{
  window = {
    border = "double",
  }
}

util.g.floaterm_keymap_toggle = '<Leader>t'

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {

      },
    },
  ensure_installed = {'bash', 'c', 'cpp', 'cmake', 'css', 'html', 'java', 'javascript', 'go', 'json', 'kotlin', 'lua', 'make', 'pug', 'php', 'markdown', 'python', 'rust', 'ruby', 'scss', 'toml', 'typescript', 'vim', 'vue', 'yaml'}
  }

vim.cmd[[
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
  \ 'outputter/buffer/opener': 'new',
  \ 'outputter/buffer/into': 1,
  \ 'outputter/buffer/close_on_empty': 1,
  \}
]]

vim.cmd[[let g:test#strategy = 'dispatch']]

require('hop').setup()
require('colorizer').setup()

vim.g.extra_whitespace_ignored_filetypes = { 'dashboard', 'TelescopePrompt', 'TelescopeResult', 'frecency' }
