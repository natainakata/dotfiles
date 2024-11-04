local indent = 2
local opt = vim.opt
local icons = require("rc.utils.icons")

-- general
opt.fenc = "utf-8"
opt.backup = false
opt.swapfile = false

-- indent
opt.expandtab = true
opt.smartindent = true
opt.tabstop = indent
opt.shiftwidth = indent

-- search
opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true
opt.wrapscan = true
opt.showmatch = true

-- clipboard
opt.clipboard:append({ "unnamed", "unnamedplus" })

-- apperance
opt.number = true
opt.termguicolors = true
opt.cursorline = true
opt.cursorcolumn = true
opt.signcolumn = "yes"
opt.visualbell = true
opt.virtualedit = "onemore"
opt.wildmode = { "list", "longest" }
opt.splitbelow = true
opt.splitright = true
opt.list = true
opt.listchars:append("eol:↴")
opt.laststatus = 3
opt.showtabline = 2
opt.cmdwinheight = 10
opt.cmdheight = 0

-- completion
opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

-- diagnostic
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
    },
  },
})

-- GUI settings
opt.guifont = { "Explex35 Console NF:h13:n" }
opt.mouse = "a"
opt.guicursor = "n-i:ver25"

-- os specific
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.g.sqlite_clib_path = "C:/lib/sqlite3.dll"
  vim.o.shell = "pwsh.exe"
  vim.o.shellcmdflag = "-NoLogo -c"
  vim.o.shellquote = '"'
  vim.o.shellxquote = ""
  opt.completeslash = "slash"
end

-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
