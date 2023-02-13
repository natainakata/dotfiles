local status, telescope = pcall(require, 'telescope')
if (not status) then return end
local actions = require('telescope.actions')
local builtins = require('telescope.builtin')

local fb_actions = require 'telescope'.extensions.file_browser.actions

local palette = _G.MiniBase16.config.palette
if palette then
  vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = palette.base08, bg = palette.base01 })
  vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = palette.base07, bg = palette.base02 })
  vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { fg = palette.base07, bg = palette.base02 })
  vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = palette.base08, bg = palette.base02 })
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = palette.base01 })
  vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = palette.base01, bg = palette.base0B })
  vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = palette.base01, bg = palette.base08 })
  vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = palette.base01, bg = palette.base0D })
  vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = palette.base05, bg = palette.base02 })
  vim.api.nvim_set_hl(0, 'TelescopeResultsDiffAdd', { fg = palette.base0B })
  vim.api.nvim_set_hl(0, 'TelescopeResultsDiffChange', { fg = palette.base0A })
  vim.api.nvim_set_hl(0, 'TelescopeResultsDiffDelete', { fg = palette.base08 })
end

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    mappings = {
      n = {
        ['q'] = actions.close
      },
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_storategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.5,
        results_width = 0.6
      },
      vertical = {
        mirror = false
      },
      width = 0.5,
      height = 0.6,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    winblend = 20,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },
  extensions = {
    file_browser = {
      theme = 'cursor',
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ['i'] = {
          ['<C-w>'] = function() vim.cmd('normal vbd') end,
        },
        ['n'] = {
          -- your custom normal mode mappings
          ['N'] = fb_actions.create,
          ['h'] = fb_actions.goto_parent_dir,
          ['/'] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

-- keymaps
vim.keymap.set('n', '<C-f>', function()
  builtins.find_files({
    no_ignore = false,
    hidden = false
  })
end)
vim.keymap.set('n', '<Leader><C-f>', function()
  builtins.find_files({
    no_ignore = true,
    hidden = true
  })
end)
vim.keymap.set('n', '<C-p>', function()
  builtins.commands()
end)
vim.keymap.set('n', '<Leader>/', function()
  builtins.live_grep()
end)
vim.keymap.set('n', '<Leader>b', function()
  builtins.buffers()
end)
vim.keymap.set('n', '<Leader>?', function()
  builtins.help_tags()
end)
vim.keymap.set('n', '<Leader><Leader>', function()
  builtins.resume()
end)
vim.keymap.set('n', '<Leader>le', function()
  builtins.diagnostics()
end)
vim.keymap.set('n', '<Leader>o', function()
  builtins.oldfiles()
end)

telescope.load_extension('file_browser')
telescope.load_extension('frecency')
vim.keymap.set('n', '<Leader>f', function()
  telescope.extensions.file_browser.file_browser({
    path = vim.fn.getcwd(),
    cwd = vim.fn.getcwd(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = 'normal',
    layout_config = { height = 0.5 }
  })
end)
vim.keymap.set('n', '<Leader>O', function()
  telescope.extensions.frecency.frecency()
end)
