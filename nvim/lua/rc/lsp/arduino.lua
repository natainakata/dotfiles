local M = {}

M.cmd = {
  "arduino-language-server",
  "-cli-config", "~/.arduino15/arduino-cli.yaml",
  "-cli", "~/bin/arduino-cli",
  "-clangd", "/usr/bin/clangd",
  "-fqbn", "arduino:avr:uno",
}

return M
