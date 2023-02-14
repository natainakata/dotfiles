local palette
palette = {
  base00 = "#242225", -- light background
  base01 = "#342d38", -- background
  base02 = "#b197a0", -- selection
  base03 = "#4d4c4e", -- comment
  base04 = "#FF3894", -- foreground
  base05 = "#8d0000", -- dark foreground
  base06 = "#ff8f91", -- light foreground
  base07 = "#ffd3d4", -- light background
  base08 = "#d24d4f", -- variables
  base09 = "#6942FF", -- integer
  base0A = "#2c5443", -- classes
  base0B = "#5f8271", -- string
  base0C = "#634355", -- escape
  base0D = "#6c7c8f", -- function
  base0E = "#917183", -- keyword
  base0F = "#3b4e62", -- tags
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
