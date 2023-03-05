$env:FZF_DEFAULT_OPTS = "
  --height=40% 
  --reverse
  --border
  --inline-info
  --prompt='→ '
  --margin=0,2
  --tiebreak=index
  --filepath-word
  --ansi"
# --preview `"bat --pager=never --color=always --style=numbers --line-range :300 {}`""
$env:FZF_DEFAULT_COMMAND = 'fd --type f --strip-cwd-prefix'

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

