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
vim.opt.guifont = 'HackGenNerd Console:h13'

vim.cmd[[
  colorscheme tokyonight
]]

vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_shortcut = {
  ['last_session']       = 'SPC s l',
  ['find_history']       = 'SPC o',
  ['find_file']          = 'SPC f',
  ['new_file']           = 'SPC c n',
  ['change_colorscheme'] = 'SPC t c',
  ['find_word']          = 'SPC /',
  ['book_marks']         = 'SPC b',
}

vim.cmd[[
let g:dps_dial#augends = [
  \ 'decimal',
  \ 'date-slash',
  \ {'kind': 'constant', 'opts': {'elements': ['true', 'false']}},
  \ {'kind': 'case', 'opts': {'cases': ['camelCase', 'snake_case'], 'cyclic': v:true}}
  \]
]]

-- vim.g.floaterm_keymap_toggle = '<Leader>t'

vim.cmd[[
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
  \ 'outputter/buffer/opener': 'new',
  \ 'outputter/buffer/into': 1,
  \ 'outputter/buffer/close_on_empty': 1,
  \}
autocmd BufNewFile,BufRead *.crs setf rust
autocmd BufNewFile,BufRead *.rs  let g:quickrun_config.rust = {'exec' : 'cargo run'}
autocmd BufNewFile,BufRead *.crs let g:quickrun_config.rust = {'exec' : 'cargo script %s -- %a'}
]]

vim.cmd[[let g:test#strategy = 'dispatch']]


vim.g.extra_whitespace_ignored_filetypes = { 'dashboard', 'TelescopePrompt', 'TelescopeResult', 'frecency' }

vim.g.sandwich_no_default_key_mappings = 1
vim.g.oparator_sandwich_no_default_key_mappings = 1

require('scrollbar').setup()
require('scrollbar.handlers.search').setup()

vim.cmd[[
  if has('win32')
    let g:sqlite_clib_path = 'C:/lib/sqlite3.dll'
  endif
]]
