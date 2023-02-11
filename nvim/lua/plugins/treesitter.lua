local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    'bash', 'c', 'cpp', 'cmake', 'css', 'html', 'java', 'javascript', 'go', 'json', 'kotlin', 'lua', 'make', 'pug', 'php', 'markdown', 'python', 'rust', 'scss', 'toml', 'typescript', 'vim', 'vue', 'yaml'
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

require 'nvim-treesitter.install'.compilers = { 'zig' }
