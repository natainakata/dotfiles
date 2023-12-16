export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export EDITOR=nvim
export BAT_THEME="OneHalfDark"
export KEYTIMEOUT=1

# export __ENABLE_TMUX=

path=(
  ~/.bin
  ~/bin
  ~/.local/bin
  $GOPATH/bin
  $path
)

eval "$(zoxide init zsh)"
eval "$(rtx activate zsh)"

eval "$(gh completion -s zsh)"
eval "$(rtx completion zsh)"

autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:default' menu select=1

zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# alias settings
# global
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

# git
alias gs='git status'
alias ga='git add'
alias gc='git commit -am'
alias glg='git log --graph --abbrev-commit --date=format:"%Y-%m-%d %H:%M:%S(%a)" --pretty=format:"%C(yellow)commit %h%Creset %Cred%d%Creset%nCommitter: %Cblue%cn%Creset <%ce>%nDate:      %Cgreen%cd%Creset%n%n    %w(80)%s%Creset%n"'
alias glo='git log --oneline --pretty=format:"%Cred%h%Creset %C(yellow)%d%Creset %s %Cgreen[%cd]%Creset %Cblue<%cn>%Creset" --date=format:"%Y-%m-%d %H:%M:%S"'
alias gcb='git checkout -b'
alias ghw='gh repo view -w $(ghq list | fzf)'
alias gp='git push'
alias gd='git diff'

# dotfiles
alias dtfl="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# shell
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'
alias vi=${commands[nvim]:-"vim"}
alias c='cdr'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'

# fzf
alias fzc='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'

# vim
alias vidot="vi $HOME/.dotfiles"
# alias nvde='(){/mnt/c/Users/natai/scoop/shims/neovide.exe --multigrid --wsl $@ &}'
alias asvim="NVIM_APPNAME=astronvim nvim"
alias nvchad="NVIM_APPNAME=nvchad nvim"

#rlwrap
alias python="rlwrap python"
alias gosh="rlwrap gosh"