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
-- if (not status) then
--   print("Lazy is not installed")
--   return
-- end
local plugins = {
  { import = "natai.plugins" },
}
require('lazy').setup(plugins,{
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = true }, -- automatically check for plugin updates
})

vim.keymap.set("n", "<Leader>lz", "<Cmd>Lazy log<CR>", { silent = true })
