return {
  {
    "echasnovski/mini.base16",
    lazy = true,
  },
  {
    "sainnhe/sonokai",
    lazy = true,
    config = function()
      vim.g.sonokai_style = "default"
      vim.g.sonokai_better_performanec = 1
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = {
      transparent = true,
      styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic,bold",
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      terminal_colors = true,
      styles = {
        keywords = { bold = true },
        comments = { italic = true },
      },
    },
  },
  {
    "tiagovla/tokyodark.nvim",
    opts = function()
      vim.g.tokyodark_enable_italic_comment = true
      vim.g.tokyodark_enable_italic = true
      vim.g.tokyodark_color_gamma = "1.0"
    end,
    config = function() end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      transparent_background = false,
      styles = {
        comments = { "italic" },
        functions = { "bold" },
        keywords = { "bold" },
        types = { "bold" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        notify = true,
      },
    },
  },
}
