local palette
palette = {
  base00 = '#282936', -- light background
  base01 = '#3a3c4e', -- background
  base02 = '#4d4f68', -- selection
  base03 = '#626483', -- comment
  base04 = '#62d6e8', -- foreground
  base05 = '#e9e9f4', -- dark foreground
  base06 = '#f1f2f8', -- light foreground
  base07 = '#f7f7fb', -- light background
  base08 = '#ea51b2', -- variables
  base09 = '#b45bcf', -- integer
  base0A = '#00f769', -- classes
  base0B = '#ebff87', -- string
  base0C = '#a1efe4', -- escape
  base0D = '#62d6e8', -- function
  base0E = '#b45bcf', -- keyword
  base0F = '#00f769', -- tags
}

if palette then
  local status, base16 = pcall(require, 'mini.base16')
  if (not status) then return end
  base16.setup({
    palette = palette,
    use_cterm = true,
    plugins = { default = true },
  })
end

