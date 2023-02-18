require("natai.options")
require("natai.keymaps")
require("natai.autocmd")
require("natai.lazy")
vim.cmd.colorscheme("base16sonokai")
for _, v in ipairs(vim.loop.os_uname()) do
  print(v)
end
