# global
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

# git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias glg='git log --graph --abbrev-commit --date=format:"%Y-%m-%d %H:%M:%S(%a)" --pretty=format:"%C(yellow)commit %h%Creset %Cred%d%Creset%nCommitter: %Cblue%cn%Creset <%ce>%nDate:      %Cgreen%cd%Creset%n%n    %w(80)%s%Creset%n"'
alias glo='git log --oneline --pretty=format:"%Cred%h%Creset %C(yellow)%d%Creset %s %Cgreen[%cd]%Creset %Cblue<%cn>%Creset" --date=format:"%Y-%m-%d %H:%M:%S"'
alias gcb='git checkout -b'
alias ghw='gh repo view -w $(ghq list | fzf)'

# shell
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'
# alias vi=${commands[nvim]:-"vim"}
alias c='cdr'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'

# fzf
alias fzc='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'

alias vidot="vi $HOME/.dotfiles"
