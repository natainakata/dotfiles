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

  vim.g.base16_palette = palette
end
