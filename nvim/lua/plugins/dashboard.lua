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
