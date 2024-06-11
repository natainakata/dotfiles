local utils = require("rc.utils")
local nmap = utils.nmap
local imap = utils.imap
local xmap = utils.xmap
local tmap = utils.tmap
local keymap = vim.keymap

keymap.set("", "<Space>", "<Nop>")
local opts = { silent = true }

-- general keymap
nmap("j", "gj")
nmap("gj", "j")
nmap("k", "gk")
nmap("gk", "k")
nmap("U", "<C-r>")
imap("jj", "<Esc>")
nmap("<Esc><Esc>", ":nohlsearch<CR>")
nmap("<Leader>q", "<Cmd>qa<CR>")

-- register
for _, key in ipairs({ "x", "X" }) do
  keymap.set({ "n", "x" }, key, [["_]] .. key, { desc = key .. " with blackhole register" })
end
-- keymap.set({ "n", "x" }, "x", [["_x]], { desc = "x with blackhole register" })
-- keymap.set({ "n", "x" }, "X", [["_X]], { desc = "X with blackhole register" })

-- text objects
for _, quote in ipairs({ '"', "'", "`" }) do
  keymap.set({ "x", "o" }, "a" .. quote, "2i" .. quote)
end

-- window and buffer
nmap("<S-Tab>", "<Cmd>bprevious<CR>")
nmap("<Tab>", "<Cmd>bnext<CR>")
nmap("<S-h>", "<Cmd>bprevious<CR>")
nmap("<S-l>", "<Cmd>bnext<CR>")

-- prefix s
nmap("s", "<Nop>", { remap = true })

-- quit
nmap("sq", "<Cmd>q<CR>")

-- window
nmap("ss", "<Cmd>split<CR><C-w>w", opts)
nmap("sv", "<Cmd>vsplit<CR><C-w>w", opts)
for _, direction in ipairs({ "h", "j", "k", "l" }) do
  nmap("<C-" .. direction .. ">", "<Cmd>wincmd " .. direction .. "<CR>", { remap = true })
  nmap("s" .. direction, "<Cmd>wincmd " .. direction .. "<CR>", { remap = true })
end
nmap("<C-Up>", "<Cmd>resize +2<CR>", { remap = true })
nmap("<C-Down>", "<Cmd>resize -2<CR>", { remap = true })
nmap("<C-Left>", "<Cmd>vertical resize -2<CR>", { remap = true })
nmap("<C-Right>", "<Cmd>vertical resize +2<CR>", { remap = true })

-- buffer and tab
nmap("st", "<Cmd>tabnew<CR>")
nmap("sw", "<Cmd>tabclose<CR>")
nmap("sp", "<Cmd>bprevious<CR>")
nmap("sn", "<Cmd>bnext<CR>")
nmap("sP", "<Cmd>tabprevious<CR>")
nmap("sN", "<Cmd>tabnext<CR>")

-- kill buffer
vim.api.nvim_create_user_command("BufferDeleteSafety", function()
  if vim.fn.input("delete buffer? (y/N): ") == "y" then
    vim.cmd([[
        redraw
        bdelete!
      ]])
    print("delete buffer!")
  end
end, { nargs = 0 })

nmap("<Leader>D", ":BufferDeleteSafety<CR>")

-- fold
nmap("Z", ":set foldmethod=indent<CR>")

-- terminal
nmap("<Leader>t", "<Cmd>terminal<CR>")
nmap("<Leader>T", "<Cmd>belowright new<CR><Cmd>terminal<CR>")
tmap("JJ", "<C-\\><C-n>")
tmap("<Esc><Esc>", "<C-\\><C-n>")

-- lazy
nmap("<Leader>lz", "<Cmd>Lazy<CR>")
