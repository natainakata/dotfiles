Set-Alias grep rg
Set-Alias ls lsd

function gs { git status }
function gc { git commit -m $args }
function ga { git add $args }
function gp { git push $args }

if (Get-Command lsd) {
  function l() { lsd -l }
  function la() { lsd -a }
  function lla() { lsd -la }
  function lt() { lsd --tree }
}

function nvde() { neovide --multigrid $args }
