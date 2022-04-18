require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {

      },
    },
  ensure_installed = {'bash', 'c', 'cpp', 'cmake', 'css', 'html', 'java', 'javascript', 'go', 'json', 'kotlin', 'lua', 'make', 'pug', 'php', 'markdown', 'python', 'rust', 'ruby', 'scss', 'toml', 'typescript', 'vim', 'vue', 'yaml'},
  yati = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["iB"] = "@block.inner",
				["aB"] = "@block.outer",
        ["ii"] = "@conditional.inner",
				["ai"] = "@conditional.outer",
				["il"] = "@loop.inner",
				["al"] = "@loop.outer",
				["ip"] = "@parameter.inner",
				["ap"] = "@parameter.outer",
      }
    },
    swap = {
			enable = true,
			swap_next = { ["'>"] = "@parameter.inner" },
			swap_previous = { ["'<"] = "@parameter.inner" },
		},
		move = {
			enable = true,
			goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
			goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
			goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
			goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
		},
  }
}

require'treesitter-context'.setup{
  enable = true
}
