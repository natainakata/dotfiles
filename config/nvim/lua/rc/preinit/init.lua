require("rc.preinit.global")
if is_nvim() then
  require("rc.preinit.options")
  require("rc.preinit.keymaps")
else
  require("rc.preinit.cursor")
end
