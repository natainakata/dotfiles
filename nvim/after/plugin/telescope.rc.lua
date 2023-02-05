local status, telescope = pcall(require, 'telescope')
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

local configuration = vim.fn['sonokai#get_configuration']()
local palette = vim.fn['sonokai#get_palette'](configuration.style, configuration.colors_override)

vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = palette.bg2[1], bg = palette.bg2[1] })
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = palette.bg4[1], bg = palette.bg4[1] })
vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { fg = palette.fg[1], bg = palette.bg4[1] })
vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = palette.red[1], bg = palette.bg4[1] })
vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = palette.bg2[1] })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = palette.bg_dim[1], bg = palette.green[1] })
vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = palette.bg_dim[1], bg = palette.red[1] })
vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = palette.bg_dim[1], bg = palette.blue[1] })
vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = palette.fg[1], bg = palette.bg4[1] })
vim.api.nvim_set_hl(0, 'TelescopeResultsDiffAdd', { fg = palette.green[1] })
vim.api.nvim_set_hl(0, 'TelescopeResultsDiffChange', { fg = palette.yellow[1] })
vim.api.nvim_set_hl(0, 'TelescopeResultsDiffDelete', { fg = palette.red[1] })


local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require 'telescope'.extensions.file_browser.actions

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
    layout_storategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8
      },
      vertical = {
        mirror = false
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    border = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    winblend = 0,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },
  extensions = {
    file_browser = {
      theme = 'ivy',
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = false,
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
vim.keymap.set('n', '<C-f>',
  function()
    builtin.find_files({
      no_ignore = false,
      hidden = true
    })
  end)
vim.keymap.set('n', '<Leader>f', function()
  builtin.find_files({
    no_ignore = true,
    hidden = true
  })
end)
vim.keymap.set('n', '<C-p>', function()
  builtin.commands()
end)
vim.keymap.set('n', '<Leader>r', function()
  builtin.live_grep()
end)
vim.keymap.set('n', '<Leader>b', function()
  builtin.buffers()
end)
vim.keymap.set('n', '<Leader>t', function()
  builtin.help_tags()
end)
vim.keymap.set('n', '<Leader><Leader>', function()
  builtin.resume()
end)
vim.keymap.set('n', '<Leader>le', function()
  builtin.diagnostics()
end)
vim.keymap.set('n', '<Leader>o', function()
  builtin.oldfiles()
end
)

telescope.load_extension('file_browser')
telescope.load_extension('frecency')

vim.keymap.set('n', '<Leader>E', function()
  telescope.extensions.file_browser.file_browser({
    path = '%:p:h',
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = 'normal',
    layout_config = {height = 0.5 }
  })
end)
vim.keymap.set('n', '<Leader>O', function()
  telescope.extensions.frecency.frecency()
end)



