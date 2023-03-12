local trans = {
  lua = true,
  vim = 1,
}
if vim.g.neovide then
  trans.lua = false
  trans.vim = 0
end

return {
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
      vim.g.sonokai_transparent_background = trans.vim
      vim.cmd.colorscheme("sonokai")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 700000000,
    opts = {
      options = {
        transprent = trans.lua,
      },
      styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic,bold",
      },
    },
    config = function()
      -- vim.cmd.colorscheme("nightfox")
    end,
  },
}
