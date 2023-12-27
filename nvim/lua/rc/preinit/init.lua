if not vim.g.vscode then
  require("rc.preinit.options")
  require("rc.preinit.keymaps")
else
  require("rc.preinit.vscode")
end
