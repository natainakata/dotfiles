local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local icons = require("natai.icons")
local M = {}
M.FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

M.FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (" " .. self.icon)
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

M.FileName = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":.")
    if filename == "" then
      return " [No Name] "
    end
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return string.format(" %s ", filename)
  end,
  hl = { fg = utils.get_highlight("Directory").fg },
}

M.FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = icons.files.modified .. " ",
    hl = { fg = "green" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = icons.files.readonly .. " ",
    hl = { fg = "orange" },
  },
}

M.FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = "cyan", bold = true, force = true }
    end
  end,
}

M.FileNameBlock = utils.insert(
  M.FileNameBlock,
  M.FileIcon,
  utils.insert(M.FileNameModifer, M.FileName), -- a new table where FileName is a child of FileNameModifier
  M.FileFlags,
  { provider = "%<" }
)

return M
