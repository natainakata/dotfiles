$HelperDir = "$HOME/.config/powershell"

. "$($HelperDir)/alias.ps1"

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -BellStyle None

# Wsl Command Import
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
  --filepath-word"
# --preview `"bat --pager=never --color=always --style=numbers --line-range :300 {}`""

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell) -join "`n"
})
Invoke-Expression (&starship init powershell)
