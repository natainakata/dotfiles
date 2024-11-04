local keymap = require("rc.init.plugins.telescope.keymaps")
local options = require("rc.init.plugins.telescope.options")

local spec = {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    enabled = is_nvim(),
    -- enabled = false,
    dependencies = {
      {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
          require("telescope").load_extension("file_browser")
        end,
        keys = keymap.file_browser,
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          require("telescope").load_extension("frecency")
        end,
        keys = keymap.frecency,
      },
      { "nvim-telescope/telescope-symbols.nvim", keys = keymap.symbols },
      "nvim-lua/plenary.nvim",
    },
    keys = keymap.core,
    config = function()
      local telescope = require("telescope")
      local viewers = require("telescope.previewers")
      local actions = require("telescope.actions")
      local sorters = require("telescope.sorters")
      local builtin = require("telescope.builtin")
      options.telescope_setup(telescope, actions, sorters, viewers)
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
