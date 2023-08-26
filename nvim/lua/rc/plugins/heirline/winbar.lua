local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local icons = require("rc.utils.icons")

local components = require("rc.plugins.heirline.components")

local separator = { icons.separator.right, icons.separator.left }
local M = {}

M.winbar = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  {
    condition = function()
      return conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix" },
      })
    end,
    init = function()
      vim.opt_local.winbar = nil
    end,
  },
  { -- A special winbar for terminals
    condition = function()
      return conditions.buffer_matches({ filetype = { "toggleterm" }, buftype = { "terminal" } })
    end,
    utils.surround(separator, "mantle", {
      components.filetype,
      components.space,
      components.terminal_name,
      components.close_button,
    }),
  },
  { -- An inactive winbar for regular files
    condition = function()
      return not conditions.is_active()
    end,
    utils.surround(
      separator,
      "mantle",
      { hl = { fg = "surface1", force = true }, { components.file_name_full, components.close_button } }
    ),
  },
  utils.surround(separator, "mantle", {
    components.lsp_info,
    components.fill,
    components.file_info,
    components.close_button,
  }),
}

return M