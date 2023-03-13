Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -WordDelimiters ";:,.[]{}()/\|^&*-=+'`" !?@#$%&_<>「」（）『』『』［］、，。：；／"
Set-PSReadLineOption -BellStyle None

