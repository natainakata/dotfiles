-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { silent = true }
local keymap = vim.keymap

keymap.set("i", "jj", "<Esc>")
keymap.set("n", "U", "<C-r>")
keymap.set("n", "Z", ":set foldmethod=indent<CR>", opts)

local mapsgroup = vim.api.nvim_create_augroup("MapsGroup", {
  clear = true,
})

vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
  pattern = "*",
  callback = function()
    keymap.set("n", "q", "<Cmd>quit<CR>", { buffer = true, silent = true })
  end,
  group = mapsgroup,
})
