local spec = {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    opts = {
      indentscope = {
        -- symbol = "▏",
        symbol = "│",
        options = { try_as_border = true },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function(_, opts)
      require("mini.ai").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.operators").setup()
      require("mini.indentscope").setup(opts.indentscope)
      require("mini.jump").setup()
    end,
  },
}

return spec
