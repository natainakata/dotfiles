local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local utils = require("rc.utils")
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

local opts = {
  defaults = {
    lazy = true,
    version = false,
  },
  dev = {
    path = "~/src/github.com/natainakata",
    patterns = {},
  },
  checker = { enabled = true, frequency = 1600 }, -- automatically check for plugin updates
  install = { colorscheme = { "nightfox", "sonokai", "onedark", "habamax" } }, performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "shada",
        "rplugin",
        "man",
      },
    },
  },
}

utils.ensure("lazy", function(m)
  m.setup({
    { import = "rc.plugins" },
  }, opts)
  m.load({ plugins = "nightfox.nvim" })
end)
