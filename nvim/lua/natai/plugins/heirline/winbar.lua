local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local icons = require("natai.utils.icons")

local Component = require("natai.plugins.heirline.component")
local Lsp = require("natai.plugins.heirline.lsp")
local File = require("natai.plugins.heirline.file")
local Terminal = require("natai.plugins.heirline.terminal")

local separator = { icons.separator.right, icons.separator.left }

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
    utils.surround(separator, "bright_bg", {
      Component.FileType,
      Component.Space,
      Terminal.TerminalName,
      Component.CloseButton,
    }),
  },
  { -- An inactive winbar for regular files
    condition = function()
      return not conditions.is_active()
    end,
    utils.surround(separator, "bright_bg", { hl = { fg = "gray", force = true }, { File, Component.CloseButton } }),
  },
  -- A winbar for regular files
  utils.surround(separator, "bright_bg", {
    Lsp.Navic,
    -- { provider = "%<" },
    Component.Align,
    File.FileNameBlock,
    Component.CloseButton,
  }),
}

return WinBars
