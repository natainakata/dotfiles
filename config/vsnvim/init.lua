require("rc.lazy")
local vscode = require("vscode")

--  option
local option = vim.opt
local indent = 2

option.backup = false
option.swapfile = false

option.expandtab = true
option.smartindent = true
option.tabstop = indent
option.shiftwidth = indent

option.hlsearch = true
option.incsearch = true
option.smartcase = true
option.wrapscan = true

option.virtualedit = "onemore"
option.clipboard:append({ "unnamed", "unnamedplus" })

option.list = true

-- keymaps

local opts = { noremap = true, silent = true }
local keymap = vim.keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap.set("", "<Space>", "<Nop>", opts)
keymap.set("n", "j", "gj", opts)
keymap.set("n", "gj", "j", opts)
keymap.set("n", "k", "gk", opts)
keymap.set("n", "gk", "k", opts)
keymap.set("n", "<Esc><Esc>", "<Cmd>nohlsearch<CR>", opts)
keymap.set("n", "x", [["_x]], opts)

-- editor navigation
keymap.set("n", "<S-h>", function()
  vscode.call("workbench.action.previousEditor")
end, opts)
keymap.set("n", "<S-l>", function()
  vscode.call("workbench.action.nextEditor")
end, opts)

keymap.set("", "s", "<Nop>")
keymap.set("n", "sj", function()
  vscode.call("workbench.action.navigateDown")
end, opts)
keymap.set("n", "sk", function()
  vscode.call("workbench.action.navigateUp")
end, opts)
keymap.set("n", "sh", function()
  vscode.call("workbench.action.navigateLeft")
end, opts)
keymap.set("n", "sl", function()
  vscode.call("workbench.action.navigateRight")
end, opts)

keymap.set("n", "gs", function()
  vscode.call("workbench.action.splitEditor")
end, opts)
keymap.set("n", "gv", function()
  vscode.call("workbench.action.splitEditorOrthogonal")
end, opts)

keymap.set("n", "<Leader>o", function()
  vscode.call("editor.action.openLink")
end, opts)

keymap.set("n", "<Leader>f", function()
  vscode.call("workbench.action.quickOpen")
end, opts)
keymap.set("n", "<Leader>p", function()
  vscode.call("workbench.action.showCommands")
end, opts)
keymap.set("n", "<Leader>b", function()
  vscode.call("workbench.action.quickOpenRecent")
end, opts)

-- sidebar
keymap.set("n", "<Leader>s", function()
  vscode.call("workbench.action.toggleSidebarVisibility")
end, opts)
keymap.set("n", "<Leader>e", function()
  vscode.call("workbench.view.explorer")
end, opts)
keymap.set("n", "<Leader>g", function()
  vscode.call("workbench.view.scm")
end, opts)

-- cursor AI
keymap.set("n", "<Leader>k", function()
  vscode.call("aipopup.action.modal.generate")
end, opts)
keymap.set("n", "<Leader>l", function()
  vscode.call("aichat.newchataction")
end, opts)

-- panel
keymap.set("n", "<Leader>j", function()
  vscode.call("workbench.action.togglePanel")
end, opts)

keymap.set("n", "<Leader>t", function()
  vscode.call("workbench.action.terminal.toggleTerminal")
end, opts)
