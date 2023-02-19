Invoke-Expression (&starship init powershell)

$HelperDir = "$HOME/.config/powershell"

. "$($HelperDir)/alias.ps1"

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

Import-WslCommand "awk", "grep", "head", "less", "sed", "seq", "tail", "man"
$WslDefaultParameterValues = @{}
$WslDefaultParameterValues["grep"] = "-E --color=auto"
$WslDefaultParameterValues["less"] = "-i"

$env:FZF_DEFAULT_OPTS = "--height=70% --reverse
  --border
  --inline-info
  --prompt='→ '
  --margin=0,2
  --tiebreak=index
  --filepath-word
  --preview `"bat --pager=never --color=always --style=numbers --line-range :300 {}`""

