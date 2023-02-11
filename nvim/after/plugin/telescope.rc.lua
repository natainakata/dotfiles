local status, telescope = pcall(require, 'telescope')
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local sonokai = require('natainakata.base16sonokai').base16_sonokai

-- local configuration = vim.fn['sonokai#get_configuration']()
-- local palette = vim.fn['sonokai#get_palette'](configuration.style, configuration.colors_override)
-- 
vim.api.nvim_set_hl(0, 'TelescopeBorder', {fg = sonokai.base08, bg = sonokai.base01 })
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = sonokai.base07, bg = sonokai.base02 })
vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { fg = sonokai.base07, bg = sonokai.base02 })
vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = sonokai.base08, bg = sonokai.base02 })
vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = sonokai.base01 })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = sonokai.base01, bg = sonokai.base0B })
vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = sonokai.base01, bg = sonokai.base08 })
vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = sonokai.base01, bg = sonokai.base0D })
vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = sonokai.base05, bg = sonokai.base02 })
vim.api.nvim_set_hl(0, 'TelescopeResultsDiffAdd', { fg = sonokai.base0B })
vim.api.nvim_set_hl(0, 'TelescopeResultsDiffChange', { fg = sonokai.base0A })
vim.api.nvim_set_hl(0, 'TelescopeResultsDiffDelete', { fg = sonokai.base08 })


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
    sorting_strategy = "ascending",
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
    border = {},
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    winblend = 10,
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



