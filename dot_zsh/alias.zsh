# global
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

# git
alias gs='git status'
alias glg='git log --graph --abbrev-commit --date=format:"%Y-%m-%d %H:%M:%S(%a)" --pretty=format:"%C(yellow)commit %h%Creset %Cred%d%Creset%nCommitter: %Cblue%cn%Creset <%ce>%nDate:      %Cgreen%cd%Creset%n%n    %w(80)%s%Creset%n"'
alias glo='git log --oneline --pretty=format:"%Cred%h%Creset %C(yellow)%d%Creset %s %Cgreen[%cd]%Creset %Cblue<%cn>%Creset" --date=format:"%Y-%m-%d %H:%M:%S"'
alias gcb='git checkout -b'

# shell
alias l='ls -la --color=auto'
alias vi=${commands[nvim]:-"vim"}
alias c='cdr'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'
  
# chezmoi
alias chap='chezmoi apply'
