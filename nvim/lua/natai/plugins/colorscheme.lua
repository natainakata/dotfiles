local trans = true
if vim.g.neovide then
  trans = false
end

local spec = {
  {
    "echasnovski/mini.base16",
    priority = 700000000,
  },
  {
    "sainnhe/sonokai",
    priority = 700000000,
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
    priority = 700000000,
    opts = {
      transparent_bg = trans,
    },
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 700000000,
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
    config = function()
      vim.cmd.colorscheme("nightfox")
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 700000000,
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
    name = "catppuccin",
    priority = 700000000,
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
}

return spec
