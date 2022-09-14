local status, nightfox = pcall(require, 'nightfox')
if (not status) then return end

nightfox.setup({
  options = {
    transparent = true,
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
})

vim.cmd[[colorscheme nightfox]]
