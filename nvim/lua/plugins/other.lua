local util = require('utils')
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

util.map('n', '<Leader>ss', ':<C-u>SessionSave<CR>', { silent = true })
util.map('n', '<Leader>sl', ':<C-u>SessionLoad<CR>', { silent = true })

vim.cmd[[
  nmap  <C-a>  <Plug>(dps-dial-increment)
  nmap  <C-x>  <Plug>(dps-dial-decrement)
  xmap  <C-a>  <Plug>(dps-dial-increment)
  xmap  <C-x>  <Plug>(dps-dial-decrement)
  xmap g<C-a> g<Plug>(dps-dial-increment)
  xmap g<C-x> g<Plug>(dps-dial-decrement)
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

require'hop'.setup()
util.map('n', '<Leader>h', ':<C-u>HopWord<CR>', { silent = true })
util.map('n', '<Leader>H', ':<C-u>HopPattern<CR>', { silent = true })
util.map('n', '<Leader>L', ':<C-u>HopLineStart<CR>', { silent = true })

