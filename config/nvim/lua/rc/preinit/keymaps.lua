local utils = require("rc.utils")
local nmap = utils.nmap
local imap = utils.imap
local xmap = utils.xmap
local tmap = utils.tmap
local keymap = vim.keymap

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

-- text objects
for _, quote in ipairs({ '"', "'", "`" }) do
  keymap.set({ "x", "o" }, "a" .. quote, "2i" .. quote)
end

-- window control
-- prefix
nmap("s", "<Nop>")

-- quit
nmap("sq", "<Cmd>q<CR>")

-- buffer
nmap("<S-Tab>", "<Cmd>bprevious<CR>")
nmap("<Tab>", "<Cmd>bnext<CR>")
nmap("<S-h>", "<Cmd>bprevious<CR>")
nmap("<S-l>", "<Cmd>bnext<CR>")
nmap("s[", "<Cmd>bprevious<CR>")
nmap("s]", "<Cmd>bnext<CR>")

-- window
nmap("ss", "<Cmd>split<CR><C-w>w")
nmap("sv", "<Cmd>vsplit<CR><C-w>w")
for key, direction in pairs({ ["h"] = ">", ["j"] = "+", ["k"] = "-", ["l"] = "<" }) do
  -- nmap("<C-" .. direction .. ">", "<Cmd>wincmd " .. direction .. "<CR>", { remap = true })
  nmap("<C-" .. key .. ">", "<Cmd>wincmd " .. key .. "<CR>", { remap = true })
  nmap("s" .. key, "<Cmd>wincmd " .. direction .. "<CR>", { remap = true })
end

-- nmap("<C-Up>", "<Cmd>resize +2<CR>", { remap = true })
-- nmap("<C-Down>", "<Cmd>resize -2<CR>", { remap = true })
-- nmap("<C-Left>", "<Cmd>vertical resize -2<CR>", { remap = true })
-- nmap("<C-Right>", "<Cmd>vertical resize +2<CR>", { remap = true })

-- tab
nmap("st", "<Cmd>tabnew<CR>")
nmap("sw", "<Cmd>tabclose<CR>")
nmap("sp", "<Cmd>tabprevious<CR>")
nmap("sn", "<Cmd>tabnext<CR>")

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
-- nmap("<Leader>t", "<Cmd>terminal<CR>")
-- nmap("<Leader>T", "<Cmd>belowright new<CR><Cmd>terminal<CR>")
tmap("JJ", "<C-\\><C-n>")
tmap("<Esc><Esc>", "<C-\\><C-n>")

-- lazy
nmap("<Leader>lz", "<Cmd>Lazy<CR>")
