require("natai.options")
if vim.g.vscode then
  require("natai.vscode.keymaps")
else
  require("natai.keymaps")
end
require("natai.autocmd")
require("natai.lazy")
