local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local M = {}

M.Align = { provider = "%=" }
M.Space = { provider = " " }
M.FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = { fg = "cyan", bold = true },
}
-- We're getting minimalists here!
M.Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%7(%l/%3L%):%2c %P",
}
-- I take no credits for this! :lion:
M.ScrollBar = {
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
M.CloseButton = {
  condition = function(self)
    return not vim.bo.modified
  end,
  update = { "WinNew", "WinClosed", "BufEnter" },
  { provider = " " },
  {
    provider = " ",
    hl = { fg = "gray" },
    on_click = {
      callback = function(_, minwid)
        vim.api.nvim_win_close(minwid, true)
      end,
      minwid = function()
        return vim.api.nvim_get_current_win()
      end,
      name = "heirline_winbar_close_button",
    },
  },
}

return M
