-- @type LazySpec[]
local spec = {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function()
      vim.opt.showmode = false
      vim.opt.laststatus = 3
      local heirline = require("heirline")
      local status = require("natai.plugins.heirline.status")
      heirline.setup({
        statusline = status,
      })
    end,
  },
}

return spec
