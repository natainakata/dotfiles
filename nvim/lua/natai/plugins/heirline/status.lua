local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local Mode = require("natai.plugins.heirline.mode")
local File = require("natai.plugins.heirline.file")
local Git = require("natai.plugins.heirline.git")
local Terminal = require("natai.plugins.heirline.terminal")
local Lsp = require("natai.plugins.heirline.lsp")
local Component = require("natai.plugins.heirline.component")

local DefaultStatusline = {

  Mode,
  Component.Space,
  File.FileNameBlock,
  Component.Space,
  Git,
  Component.Space,
  Lsp.Diagnostics,
  Component.Align,
  Lsp.LSPActive,
  Component.Space,
  Component.FileType,
  Component.Space,
  Component.Ruler,
  Component.Space,
  Component.ScrollBar,
}

local TerminalStatusLine = {
  condition = function()
    return conditions.buffer_matches({ filetype = { "toggleterm" }, buftype = { "terminal" } })
  end,
  { condition = conditions.is_active, Mode, Component.Space },
  Component.FileType,
  Component.Space,
  Terminal.TerminalName,
  Component.Align,
}

local StatusLines = {

  hl = function()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end,
  fallthrough = false,

  TerminalStatusLine,
  DefaultStatusline,
}

return StatusLines
