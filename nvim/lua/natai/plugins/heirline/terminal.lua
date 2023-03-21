local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local M = {}

M.TerminalName = {
  provider = function()
    local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
    return " " .. tname
  end,
  hl = { fg = "blue", bold = true },
}

return M
