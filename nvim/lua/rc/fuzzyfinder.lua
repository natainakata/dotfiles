local opt = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', '<C-p>', '<cmd>Telescope command_palette<CR>', opt)
keymap('n', '<C-f>', '<cmd>Telescope find_files<CR>', opt)
keymap('n', '<Leader>f', '<cmd>Telescope find_files hidden=true<CR>', opt)
keymap('n', '<Leader>o', '<cmd>Telescope oldfiles<CR>', opt)
keymap('n', '<Leader>O', '<cmd>Telescope frecency<CR>', opt)
keymap('n', '<Leader>p', '<cmd>Telescope project<CR>', opt)
keymap('n', '<Leader>c', '<cmd>Telescope commands<CR>', opt)
keymap('n', '<Leader>C', ':Cheatsheet<CR>', opt)
keymap('n', '<Leader>/', '<cmd>Telescope live_grep<CR>', opt)
keymap('n', '<Leader>b', '<cmd>Telescope buffers<CR>', opt)
keymap('n', '<Leader>B', '<cmd>Telescope builtin<CR>', opt)
keymap('n', '<Leader><C-t>', '<cmd>Telescope help_tags<CR>', opt)

require 'telescope'.setup {
  pickers = {
    buffers = {
      theme = "dropdown",
      mappings = {
        n = {
          ['<C-d>'] = require('telescope.actions').delete_buffer
        },
        i = {
          ['<C-d>'] = require('telescope.actions').delete_buffer
        }
      }
    }
  },
  extensions = {
    command_palette = {
      {"File",
        { "save current file (C-s)", ':w' },
        { "save all file (C-A-s)", ':wa' },
        { "quit (C-q)", ':qa' },
        { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1},
        { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
        { "files (C-f)", ":lua require('telescope.builtin').find_files() hidden=true", 1 },
      },
      {"Help",
        { "tips", ":help tips" },
        { "cheetsheet", ":Cheatsheet" },
        { "tutorial", ":help tutor" },
        { "summary", ":help summary" },
        { "quick reference", ":help quickref" },
        { "search help (F1)", ":lua require('telescope.builtin').help_tags()", 1 }
      },
      {"Vim",
        { "reload vimrc", ":source $MYVIMRC" },
        { 'check health', ":checkhealth" },
        { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
        { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
        { "vim options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
      }
    },
    frecency = {
      show_scores = true,
      workspaces = {
        ["conf"]  = "/home/natai/.config",
        ["dot"]  = "/home/natai/.dotfiles",
      }
    },
    ['ui-select'] = {
      require("telescope.themes").get_dropdown {
      }
    }
  }
}

require 'telescope'.load_extension('gh')
require 'telescope'.load_extension('ghq')
require 'telescope'.load_extension('project')
require 'telescope'.load_extension('command_palette')
require 'telescope'.load_extension('frecency')
require 'telescope'.load_extension('packer')
require 'telescope'.load_extension('ui-select')

vim.cmd[[
augroup transparent-windows
  autocmd!
  autocmd FileType TelescopePrompt  set winblend=10
  autocmd FileType TelescopeResults set winblend=10
  autocmd User TelescopePreviewerLoaded set winblend=10
augroup END
]]
