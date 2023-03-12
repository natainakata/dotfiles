local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local utils = require("natai.util")
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

vim.g.loaded_gzip = 1
vim.g.loaded_matchit = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tar = 1

local opts = {
  defaults = {
    lazy = false,
    version = false,
  },
  dev = {
    path = "~/src/github.com/natainakata",
    patterns = {},
  },
  checker = { enabled = true, frequency = 1600 }, -- automatically check for plugin updates
  install = { colorscheme = { "nightfox", "habamax" } },
}

utils.ensure("lazy", function(m)
  m.setup({
    { import = "natai.plugins" },
  }, opts)
end)
