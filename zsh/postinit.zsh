zoxide_cache="/tmp/zoxide_cache.zsh"
if [[ ! -r "$zoxide_cache" ]]; then
  zoxide init zsh > $zoxide_cache
fi
source $zoxide_cache
unset zoxide_cache

rtx_config="$XDG_CONFIG_HOME/rtx/config.toml"
rtx_cache="/tmp/rtx_cache.zsh"
if [[ ! -r "$rtx_cache" ]]; then
  rtx activate zsh > $rtx_cache
fi
source $rtx_cache
unset rtx_cache rtx_config

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

if [[ ! -r $ZSHRC_DIR/functions/_gh ]]; then
  gh completion -s zsh > $ZSHRC_DIR/functions/_gh
fi

if [[ ! -r $ZSHRC_DIR/functions/_rtx ]] then
  rtx completion zsh > $ZSHRC_DIR/functions/_rtx
fi

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

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:default' menu select=1

zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
bindkey '^F' autosuggest-accept

export IGNOREEOF=2
setopt ignore_eof
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end


