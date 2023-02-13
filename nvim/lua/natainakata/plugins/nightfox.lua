local status, nightfox = pcall(require, 'nightfox')
if (not status) then return end

local config = {
  options = {
    transparent = true,
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
}
if (vim.fn.exists('g:neovide') == 1) then
  config.options.transparent = false
end

nightfox.setup(config)
-- vim.cmd[[colorscheme nordfox]]
