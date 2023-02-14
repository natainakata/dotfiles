local palette
palette = {
  base00 = "#282936", -- light background
  base01 = "#3a3c4e", -- background
  base02 = "#4d4f68", -- selection
  base03 = "#626483", -- comment
  base04 = "#62d6e8", -- foreground
  base05 = "#e9e9f4", -- dark foreground
  base06 = "#f1f2f8", -- light foreground
  base07 = "#f7f7fb", -- light background
  base08 = "#ea51b2", -- variables
  base09 = "#b45bcf", -- integer
  base0A = "#00f769", -- classes
  base0B = "#ebff87", -- string
  base0C = "#a1efe4", -- escape
  base0D = "#62d6e8", -- function
  base0E = "#b45bcf", -- keyword
  base0F = "#00f769", -- tags
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
