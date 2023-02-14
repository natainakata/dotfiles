local palette
palette = {
  base00 = "#2d2a2e", -- light background
  base01 = "#37343a", -- background
  base02 = "#423f46", -- selection
  base03 = "#848089", -- comment
  base04 = "#66d9ef", -- foreground
  base05 = "#e3e1e4", -- dark foreground
  base06 = "#a1efe4", -- light foreground
  base07 = "#f8f8f2", -- light background
  base08 = "#f85e84", -- variables
  base09 = "#ef9062", -- integer
  base0A = "#a6e22e", -- classes
  base0B = "#e5c463", -- string
  base0C = "#66d9ef", -- escape
  base0D = "#9ecd6f", -- function
  base0E = "#a1efe4", -- keyword
  base0F = "#f9f8f5", -- tags
}

if palette then
  local status, base16 = pcall(require, "mini.base16")
  if not status then
    return
  end
  base16.setup({
    palette = palette,
    use_cterm = false,
    plugins = { default = true },
  })
  local telescopePalette = {
    TelescopeBorder = { fg = palette.base01, bg = palette.base01 },
    TelescopePromptBorder = { fg = palette.base02, bg = palette.base02 },
    TelescopePromptNormal = { fg = palette.base07, bg = palette.base02 },
    TelescopePromptPrefix = { fg = palette.base08, bg = palette.base02 },
    TelescopeNormal = { bg = palette.base01 },
    TelescopePreviewTitle = { fg = palette.base01, bg = palette.base0B },
    TelescopePromptTitle = { fg = palette.base01, bg = palette.base08 },
    TelescopeResultsTitle = { fg = palette.base01, bg = palette.base0D },
    TelescopeSelection = { fg = palette.base05, bg = palette.base02 },
    TelescopeResultsDiffAdd = { fg = palette.base0B },
    TelescopeResultsDiffChange = { fg = palette.base0A },
    TelescopeResultsDiffDelete = { fg = palette.base08 },
  }
  for hl, col in pairs(telescopePalette) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end
