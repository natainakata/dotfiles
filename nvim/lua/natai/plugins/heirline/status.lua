-- local icons = require("natai.icons")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local Align = { provider = "%=" }
local Space = { provider = " " }

local Mode = require("natai.plugins.heirline.mode")
Mode = utils.surround({ "", "" }, "bright_bg", { Mode })
local File = require("natai.plugins.heirline.file")
local Git = require("natai.plugins.heirline.git")
local FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = { fg = "cyan", bold = true },
}
-- We're getting minimalists here!
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%7(%l/%3L%):%2c %P",
}
-- I take no credits for this! :lion:
local ScrollBar = {
  static = {
    sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
    -- Another variant, because the more choice the better.
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = "green", bg = utils.get_highlight("StatusLineNC").bg },
}

local Lsp = require("natai.plugins.heirline.lsp")

local DefaultStatusline = {
  hl = function()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end,
  Mode,
  Space,
  File,
  Space,
  Git,
  Space,
  Lsp.Diagnostics,
  Align,
  Lsp.Navic,
  Align,
  Lsp.LSPActive,
  Space,
  FileType,
  Space,
  Ruler,
  Space,
  ScrollBar,
}

return DefaultStatusline
