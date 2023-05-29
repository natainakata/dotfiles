local indent = 2
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.fenc = "utf-8"
opt.backup = false
opt.swapfile = false

opt.expandtab = true
opt.smartindent = true
opt.tabstop = indent
opt.shiftwidth = indent

opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true
opt.wrapscan = true
opt.number = true
opt.termguicolors = true
opt.cursorline = true
opt.visualbell = true
opt.wildmode = { "list", "longest" }

opt.laststatus = 3
opt.showtabline = 2
opt.cmdwinheight = 10
opt.cmdheight = 0

opt.virtualedit = "onemore"

opt.list = true
if not vim.g.vscode then
  opt.listchars:append("eol:↴")
  opt.showmatch = true
  opt.cursorcolumn = true
end
opt.mouse = "a"
opt.clipboard:append({ "unnamed", "unnamedplus" })

opt.pumblend = 10
-- opt.winblend = 20
opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

vim.opt.guifont = { "UDEV Gothic 35NFLG:h14:n" }
vim.opt.guifontwide = { "UDEV Gothic 35NFLG:h14:n" }

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.g.sqlite_clib_path = "C:/lib/sqlite3.dll"
  vim.o.shell = "pwsh.exe"
  vim.o.shellcmdflag = "-NoLogo -c"
  vim.o.shellquote = '"'
  vim.o.shellxquote = ""
end

if vim.loop.os_uname().sysname == "Linux" then
  if vim.fn.system("uname -a | grep microsoft") then
    vim.g.clipboard = {
      name = "WslClipboard",
      copy = {
        ["+"] = "win32yank -i",
        ["*"] = "win32yank -i",
      },
      paste = {
        ["+"] = "win32yank -o",
        ["*"] = "win32yank -o",
      },
      cache_enabled = 1,
    }
  end
end
