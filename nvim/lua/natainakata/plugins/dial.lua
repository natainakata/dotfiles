local status, dial = pcall(require, 'dial.config')
if (not status) then return end

local augend = require("dial.augend")
dial.augends:register_group{
  -- augends used when group with name `mygroup` is specified
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.date.alias["%Y/%m/%d"],
  },
}
