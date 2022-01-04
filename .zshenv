export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export EDITOR=${commands[nvim]:-"vim"}

path=(
  ~/bin
  ~/.local/bin
  ~/.deno/bin
  $path
)

