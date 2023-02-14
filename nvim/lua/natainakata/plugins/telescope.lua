local status, telescope = pcall(require, 'telescope')
if (not status) then return end
local actions = require('telescope.actions')
local builtins = require('telescope.builtin')

local fb_actions = require 'telescope'.extensions.file_browser.actions
local wk = require('which-key')
telescope.load_extension('file_browser')
telescope.load_extension('frecency')

local palette = _G.MiniBase16.config.palette
if palette then
  local telescopePalette = {
    TelescopeBorder = { fg = palette.base01, bg = palette.base01 },
    TelescopePromptBorder = { fg = palette.base02, bg = palette.base02 },
    TelescopePromptNormal = { fg = palette.base07, bg = palette.base02 },
    TelescopePromptPrefix = { fg = palette.base08, bg = palette.base02 },
    TelescopeNormal = { bg = palette.base01 },
    TelescopePreviewTitle = { fg = palette.base01, bg = palette.base0B },
    TelescopePromptTitle = { fg = palette.base01, bg = palette.base08 },
    TelescopeResultsTitle = { fg = palette.base01, bg = palette.base0D },
    TelescopeSelection = { fg = palette.base05, bg = palette.base02 },
    TelescopeResultsDiffAdd = { fg = palette.base0B },
    TelescopeResultsDiffChange = { fg = palette.base0A },
    TelescopeResultsDiffDelete = { fg = palette.base08 },
  }
  for hl, col in pairs(telescopePalette) do
    vim.api.nvim_set_hl(0, hl, col)
  end
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
      width = 0.7,
      height = 0.8,
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
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
    }
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
wk.register({
  ['<C-f>'] = {
    function()
      builtins.find_files({
        no_ignore = false,
        hidden = false
      })
    end, 'Find File'},
  ['<Leader><C-f>'] = {
    function()
      builtins.find_files({
        no_ignore = true,
        hidden = true
      })
    end, 'Find File (ALL)'},
  ['<C-p>'] = {
    function ()
      builtins.commands()
    end, 'Command Palette'},
  ['<C-/>'] = {
    function ()
      builtins.live_grep()
    end, 'Live Grep'},
  ['<Leader>b'] = {
    function ()
      builtins.buffers()
    end, 'Buffer List'},
  ['<Leader>?'] = {
    function ()
      builtins.help_tags()
    end, 'Neovim Documents'},
  ['<Leader><Leader>'] = {
    function ()
      builtins.resume()
    end, 'Telescope Resume'
  },
  ['<Leader>le'] = {
    function ()
      builtins.diagnostics()
    end, 'LSP Diagnostics'},
  ['<Leader>r'] = {
    function()
      builtins.oldfiles()
    end, 'Old Files'},
  ['<Leader>f'] = {
    function()
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
    end, 'File Browser'},
  ['<Leader>O'] = {
    function()
      telescope.extensions.frecency.frecency()
    end, 'Frecency'}
})

