local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local Component = require("natai.plugins.heirline.component")
local File = require("natai.plugins.heirline.file")
local Terminal = require("natai.plugins.heirline.terminal")

local WinBars = {
  fallthrough = false,
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
    utils.surround({ "", "" }, "bright_bg", {
      Component.FileType,
      Component.Space,
      Terminal.TerminalName,
    }),
  },
  { -- An inactive winbar for regular files
    condition = function()
      return not conditions.is_active()
    end,
    utils.surround({ "", "" }, "bright_bg", { hl = { fg = "gray", force = true }, File }),
  },
  -- A winbar for regular files
  utils.surround({ "", "" }, "bright_bg", File),
}

return WinBars
