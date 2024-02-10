local Config = require("config")

require("events.update-status").setup()
require("events.format-tab-title").setup()

return Config:init()
  :append(require("config.appearance"))
  :append(require("config.fonts"))
  :append(require("config.domains"))
  :append(require("config.keybinds"))
  :append(require("config.launch")).options
