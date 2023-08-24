local conditions = require("heirline.conditions")

local mode = require("rc.plugins.heirline.mode")
local components = require("rc.plugins.heirline.components")

local M = {}

M.defaults = {
  mode,
  components.space,
  components.file_info,
  components.space,
  {
    condition = conditions.is_git_repo,
    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    components.git_branch,
    components.git_diff,
    hl = { fg = "maroon" },
  },

  components.space,
  components.diagnostics,
  components.fill,
  components.lsp_active,
  components.space,
  components.filetype,
  components.space,
  components.ruler,
  components.space,
  components.scrollbar,
}

M.terminal = {
  condition = function()
    return conditions.buffer_matches({ filetype = { "toggleterm" }, buftype = { "terminal" } })
  end,
  { condition = conditions.is_active, mode, components.space },
  components.filetype,
  components.space,
  components.terminal_name,
  components.fill,
}

M.statusline = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  hl = { bg = "mantle" },
  fallthrough = false,

  M.defaults,
  M.terminal,
}

return M
