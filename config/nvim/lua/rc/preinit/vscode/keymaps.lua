local utils = require("rc.utils")
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
nmap("<S-h>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
nmap("<S-l>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")

nmap("<C-j>", "<Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>", { remap = true })
nmap("<C-k>", "<Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>", { remap = true })
nmap("<C-h>", "<Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>", { remap = true })
nmap("<C-l>", "<Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>", { remap = true })

-- window split
nmap("gs", "<Cmd>call VSCodeNotify('workbench.action.splitEditor')<CR><C-w>w")
nmap("gv", "<Cmd>call VSCodeNotify('workbench.action.splitEditorOrthogonal')<CR><C-w>w")

-- palette
nmap("<Leader>f", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
nmap("<Leader>p", "<Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>")
nmap("<Leader>b", "<Cmd>call VSCodeNotify('workbench.action.quickOpenRecent')<CR>")

-- sidebar
nmap("<Leader>s", "<Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>")
nmap("<Leader>e", "<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>")


-- use cursor only
-- nmap("<Leader>l", "<Cmd>call VSCodeNotify('aichat.newchataction')<CR>")
-- nmap("<Leader>k", "<Cmd>call VSCodeNotify('aipopup.action.modal.generate')<CR ")
