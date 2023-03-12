local utils = require("natai.util")
local spec = {
  { "yuki-yano/denops-lazy.nvim", lazy = true },
  { "vim-denops/denops.vim", event = "VeryLazy" },
  {
    "lambdalisue/gin.vim",
    dependencies = "vim-denops/denops.vim",
    event = "VeryLazy",
    keys = {
      { "<C-g>c", "<Cmd>Gin ++wait add . | Gin commit<CR>", desc = "Git Commit" },
      { "<C-g><C-g>", ":Gin ", desc = "Gin Palette" },
    },
    config = function()
      utils.ensure("denops-lazy", function(m)
        m.load("gin.vim", {})
      end)
    end,
  },
}

return spec
