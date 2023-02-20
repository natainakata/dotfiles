local trans = true
if vim.g.neovide then
  trans = false
end

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
      if not vim.g.neovide then
        vim.g.sonokai_transparent_background = 1
      end
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    config = function()
      require("dracula").setup({
        transparent_bg = trans,
      })
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = {
      options = {
        transparent = trans,
      },
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
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      transparent_background = trans,
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
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
    config = function()
      require("github-theme").setup({
        transparent = trans,
        theme_style = "dark",
        keyword_style = "NONE",
      })
    end,
  },
}
