local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local icons = require("natai.utils.icons")

local M = {}

M.fill = { provider = "%=" }

M.space = { provider = " " }

M.bufnr = {
  provider = function(self)
    return tostring(self.bufnr) .. "."
  end,
  hl = "purple",
}

M.filetype = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = { fg = "cyan", bold = true },
}

M.file_icon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (" " .. self.icon)
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

M.file_name_full = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":.")
    if filename == "" then
      return " [No Name] "
    end
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return string.format(" %s ", filename)
  end,
  hl = { fg = utils.get_highlight("Directory").fg },
}

M.file_name = {
  provider = function(self)
    local filename = self.filename
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
    return filename
  end,
  hl = function(self)
    return { bold = self.is_active or self.is_visible }
  end,
}

M.file_modified = {
  condition = function()
    return vim.bo.modified
  end,
  provider = icons.files.modified .. " ",
  hl = { fg = "green" },
}

M.file_readonly = {
  condition = function()
    return not vim.bo.modifiable or vim.bo.readonly
  end,
  provider = icons.files.readonly .. " ",
  hl = { fg = "orange" },
}

M.file_info = {
  M.file_icon,
  M.file_name_full,
  M.file_modified,
  M.file_readonly,
}

M.git_branch = { -- git branch name
  provider = function(self)
    return icons.git.branch .. " " .. self.status_dict.head
  end,
  hl = { bold = true },
}

M.git_diff = {
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "(",
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (icons.git.added .. " " .. count)
    end,
    hl = { fg = "green" },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (icons.git.removed .. " " .. count)
    end,
    hl = { fg = "red" },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (icons.git.renamed .. " " .. count)
    end,
    hl = { fg = "blue" },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ")",
  },
}

M.diagnostics = {

  condition = conditions.has_diagnostics(),

  static = {
    error_icon = icons.diagnostics.Error,
    warn_icon = icons.diagnostics.Warn,
    info_icon = icons.diagnostics.Info,
    hint_icon = icons.diagnostics.Hint,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = "![",
  },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
  {
    provider = "]",
  },
}

M.lsp_active = {
  condition = conditions.lsp_attached(),
  update = { "LspAttach", "LspDetach" },

  -- You can keep it simple,
  -- provider = " [LSP]",

  -- Or complicate things a bit and get the servers names
  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      if server.name ~= "null-ls" then
        table.insert(names, server.name)
      end
    end
    return " [" .. table.concat(names, " ") .. "]"
  end,
  hl = { fg = "green", bold = true },
}

M.lsp_info = {
  condition = function()
    return require("nvim-navic").is_available()
  end,
  static = {
    -- create a type highlight map
    type_hl = {
      File = "Directory",
      Module = "@include",
      Namespace = "@namespace",
      Package = "@include",
      Class = "@structure",
      Method = "@method",
      Property = "@property",
      Field = "@field",
      Constructor = "@constructor",
      Enum = "@field",
      Interface = "@type",
      Function = "@function",
      Variable = "@variable",
      Constant = "@constant",
      String = "@string",
      Number = "@number",
      Boolean = "@boolean",
      Array = "@field",
      Object = "@type",
      Key = "@keyword",
      Null = "@comment",
      EnumMember = "@field",
      Struct = "@structure",
      Event = "@keyword",
      Operator = "@operator",
      TypeParameter = "@type",
    },
    -- bit operation dark magic, see below...
    enc = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
    dec = function(c)
      local line = bit.rshift(c, 16)
      local col = bit.band(bit.rshift(c, 6), 1023)
      local winnr = bit.band(c, 63)
      return line, col, winnr
    end,
  },
  init = function(self)
    local data = require("nvim-navic").get_data() or {}
    local children = {}
    -- create a child for each level
    for i, d in ipairs(data) do
      -- encode line and column numbers into a single integer
      local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      local child = {
        {
          provider = d.icon,
          hl = self.type_hl[d.type],
        },
        {
          -- escape `%`s (elixir) and buggy default separators
          provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
          -- highlight icon only or location name as well
          -- hl = self.type_hl[d.type],

          on_click = {
            -- pass the encoded position through minwid
            minwid = pos,
            callback = function(_, minwid)
              -- decode
              local line, col, winnr = self.dec(minwid)
              vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
            end,
            name = "heirline_navic",
          },
        },
      }
      -- add a separator only if needed
      if #data > 1 and i < #data then
        table.insert(child, {
          provider = " > ",
          hl = { fg = "bright_fg" },
        })
      end
      table.insert(children, child)
    end
    -- instantiate the new child, overwriting the previous one
    self.child = self:new(children, 1)
  end,
  provider = function(self)
    return self.child:eval()
  end,
  hl = { fg = "gray" },
  update = "CursorMoved",
}

-- We're getting minimalists here!
M.ruler = { -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%7(%l/%3L%):%2c %P",
} -- I take no credits for this! :lion:
M.scrollbar = {
  static = {
    sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
    -- Another variant, because the more choice the better.
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = "green", bg = utils.get_highlight("StatusLineNC").bg },
}

M.terminal_name = {
  provider = function()
    local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
    return " " .. tname
  end,
  hl = { fg = "blue", bold = true },
}

M.close_button = {
  condition = function(self)
    return not vim.bo.modified
  end,
  update = { "WinNew", "WinClosed", "BufEnter" },
  { provider = " " },
  {
    provider = icons.other.close,
    hl = { fg = "gray" },
    on_click = {
      callback = function(_, minwid)
        vim.api.nvim_win_close(minwid, true)
      end,
      minwid = function()
        return vim.api.nvim_get_current_win()
      end,
      name = "heirline_winbar_close_button",
    },
  },
}

return M
