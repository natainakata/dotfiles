local utils = require("rc.utils")
local vscode = require("vscode")
local nmap = utils.nmap
local imap = utils.imap
local xmap = utils.xmap
local tmap = utils.tmap

vim.keymap.set("", "<Space>", "<Nop>")

-- general keymap
nmap("j", "gj")
nmap("gj", "j")
nmap("k", "gk")
nmap("gk", "k")
nmap("U", "<C-r>")
imap("jj", "<Esc>")
nmap("<Esc><Esc>", ":nohlsearch<CR>")
nmap("<Leader>q", "<Cmd>qa<cr>")
nmap("x", [["_x]])

-- window and buffer
-- editor navigation
nmap("<S-h>", function() vscode.call("workbench.action.previousEditor") end)
nmap("<S-l>", function() vscode.call("workbench.action.nextEditor") end)

nmap("sj", function() vscode.call("workbench.action.navigateDown") end)
nmap("sk", function() vscode.call("workbench.action.navigateUp") end)
nmap("sh", function() vscode.call("workbench.action.navigateLeft") end)
nmap("sl", function() vscode.call("workbench.action.navigateRight") end)

-- window split
nmap("gs", function() vscode.call("workbench.action.splitEditor") end)
nmap("gv", function() vscode.call("workbench.action.splitEditorOrthogonal") end)

-- palette
nmap("<Leader>f", function() vscode.call("workbench.action.quickOpen") end)
nmap("<Leader>p", function() vscode.call("workbench.action.showCommands") end)
nmap("<Leader>b", function() vscode.call("workbench.action.quickOpenRecent") end)

-- sidebar
nmap("<Leader>s", function() vscode.call("workbench.action.toggleSidebarVisibility") end)
nmap("<Leader>e", function() vscode.call("workbench.view.explorer") end)

nmap("<Leader>j", function() vscode.call("workbench.action.togglePanel") end)