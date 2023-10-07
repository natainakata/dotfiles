local keymap = require("rc.plugins.telescope.keymaps")
local icons = require("rc.utils.icons")
local function telescope_setup(core, actions, sorters, viewers)
  core.setup({
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
          ["q"] = actions.close,
        },
      },
      prompt_prefix = icons.other.search .. " ",
      selection_caret = "  ",
      entry_prefix = "  ",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_storategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.5,
          results_width = 0.6,
        },
        vertical = {
          mirror = false,
        },
        width = 0.7,
        height = 0.8,
        preview_cutoff = 120,
      },
      file_sorter = sorters.get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = sorters.get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      file_previewer = viewers.vim_buffer_cat.new,
      grep_previewer = viewers.vim_buffer_vimgrep.new,
      qflist_previewer = viewers.vim_buffer_qflist.new,
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      },
    },
    extensions = {
      file_browser = {
        theme = "cursor",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = false,
        mappings = {
          -- your custom insert mode mappings
          ["i"] = {
            ["<C-w>"] = function()
              vim.cmd("normal vbd")
            end,
          },
          ["n"] = {
            -- your custom normal mode mappings
            ["N"] = core.extensions.file_browser.actions.create,
            ["h"] = core.extensions.file_browser.actions.goto_parent_dir,
            ["/"] = function()
              vim.cmd("startinsert")
            end,
          },
        },
      },
    },
  })
  core.load_extension("file_browser")
--   core.load_extension("frecency")
end

local spec = {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      {
        "nvim-telescope/telescope-file-browser.nvim",
       -- keys = keymap.file_browser,
      },
      -- {
      --   "nvim-telescope/telescope-frecency.nvim",
      --   dependencies = "tami5/sqlite.lua",
      --  --  keys = keymap.frecency,
      -- },
      { "nvim-telescope/telescope-symbols.nvim", keys = keymap.symbols },
      "nvim-lua/plenary.nvim",
    },
    -- keys = keymap.core,
    config = function()
      local telescope = require("telescope")
      local viewers = require("telescope.previewers")
      local actions = require("telescope.actions")
      local sorters = require("telescope.sorters")
      local builtin = require("telescope.builtin")
      telescope_setup(telescope, actions, sorters, viewers)
      --:Telescope keymap regisiteration
      for k, v in pairs(builtin) do
        if type(v) == "function" then
          vim.keymap.set("n", "<Plug>(telescope." .. k .. ")", v)
        end
      end
    end,
  },
}

return spec
