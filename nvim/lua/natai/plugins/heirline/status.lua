-- local conditions = require("heirline.conditions")
local Mode = require("natai.plugins.heirline.mode")

return {
  Mode,
  { -- CWD
    provider = function()
      return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    end,
  },
  {
    provider = "%=",
  },
  {
    provider = "%=",
  },
}
