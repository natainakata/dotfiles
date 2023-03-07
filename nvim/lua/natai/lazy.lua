local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local plugins = {
  { import = "natai.plugins" },
}

require("lazy").setup(plugins, {
  defaults = {
    lazy = false,
    version = false,
  },
  dev = {
    path = "~/src",
    patterns = {}
  },
  checker = { enabled = true }, -- automatically check for plugin updates
})
