$helperDir = "$HOME/.config/powershell"

. "$($helperDir)/alias.ps1"
. "$($helperDir)/readline.ps1"
. "$($helperDir)/fzf.ps1"

# Wsl Command Import
Import-WslCommand 'awk', 'grep', 'head', 'less', 'sed', 'seq', 'tail', 'man'
$WslDefaultParameterValues = @{}
$WslDefaultParameterValues['grep'] = '-E --color=auto'
$WslDefaultParameterValues['less'] = '-i'
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) {
      'prompt' 
    } else {
      'pwd' 
    }
    (zoxide init --hook $hook powershell) -join "`n"
  })
Invoke-Expression (&starship init powershell)
