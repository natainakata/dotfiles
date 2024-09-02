local spec = {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    keys = {
      {
        "m",
        function()
          require("substitute").operator()
        end,
      },
      {
        "mm",
        function()
          require("substitute").line()
        end,
        desc = "Lines",
      },
      {
        "M",
        function()
          require("substitute").eol()
        end,
        desc = "Substitute File",
      },

      {
        "m",
        function()
          require("substitute").visual()
        end,
        mode = "x",
        desc = "Substitute Visual",
      },
    },
    config = true,
  },
  {
    "phaazon/hop.nvim",
    config = true,
    event = "VeryLazy",
    keys = {
      { "<Leader>h", ":<C-u>HopWord<CR>",      silent = true, desc = "Hop Word" },
      { "<Leader>H", ":<C-u>HopPattern<CR>",   silent = true, desc = "Hop Pattern" },
      { "<Leader>L", ":<C-u>HopLineStart<CR>", silent = true, desc = "Hop Line" },
    },
  },
  {
    'echasnovski/mini.ai',
    version = false,
    event = "VeryLazy",
  },
  {
    'machakann/vim-highlightedyank',
    event = "VeryLazy",
    config = function()
      vim.g.highlightedyank_highlight_duration = 300
    end
  },

}

return spec
