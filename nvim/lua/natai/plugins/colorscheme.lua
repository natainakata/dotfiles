return {
  {
    "echasnovski/mini.base16",
    lazy = true,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = function()
      local trans = true
      if vim.fn.exists("g:neovide") == 1 then
        trans = false
      end

      return {
        transparent = trans,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      }
    end,
  },
}
