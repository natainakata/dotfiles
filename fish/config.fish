if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx XDG_DATA_HOME $HOME/.local/share
set -gx AQUA_ROOT_DIR $XDG_DATA_HOME/aquaproj-aqua
set -gx AQUA_GLOBAL_CONFIG $HOME/.config/aqua/aqua.yaml
fish_add_path $AQUA_ROOT_DIR/bin

rtx activate fish | source
starship init fish | source

set -U fisher_path "$HOME/.local/share/fisher"
if test ! -d "$HOME/.local/share/fisher"
  mkdir -p "$HOME/.local/share/fisher"
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
end

abbr -a gs 'git status'
abbr -a ga 'git add'
abbr -a gc 'git commit -am'
abbr -a glg 'git log --graph --abbrev-commit --date=format:"%Y-%m-%d %H:%M:%S(%a)" --pretty=format:"%C(yellow)commit %h%Creset %Cred%d%Creset%nCommitter: %Cblue%cn%Creset <%ce>%nDate:      %Cgreen%cd%Creset%n%n    %w(80)%s%Creset%n'
abbr -a glo 'git log --oneline --pretty=format:"%Cred%h%Creset %C(yellow)%d%Creset %s %Cgreen[%cd]%Creset %Cblue<%cn>%Creset" --date=format:"%Y-%m-%d %H:%M:%S"'
abbr -a gcb 'git checkout -b'
abbr -a ghw 'gh repo view -w (ghq list | fzf)'
abbr -a gp 'git push'
abbr -a gd 'git diff'
abbr -a l 'lsd -l'
abbr -a la 'lsd -a'
abbr -a lla 'lsd -la'
abbr -a lt 'lsd --tree'
abbr -a cp 'cp -i'
abbr -a rm 'rm -i'
abbr -a mkdir 'mkdir -p'
abbr -a diff 'diff -U1'

if test -n "$TMUX"
  set -U FZF_DEFAULT_OPTS \
    '--height=40%' \
    '--reverse' \
    '--inline-info' \
    '--prompt="→ "' \
    '--margin=0,2' \
    '--tiebreak=index' \
    '--filepath-word' \
    '--ansi'
  set -U FZF_TMUX 1
else
  set -U FZF_DEFAULT_OPTS \
    '--height=70%' \
    '--reverse' \
    '--border' \
    '--inline-info' \
    '--prompt="→ "' \
    '--margin=0,2' \
    '--tiebreak=index' \
    '--filepath-word' \
    '--ansi'
end

function fzf --wraps=fzf --description="Use fzf-tmux if in tmux session"
  if set --query TMUX
    fzf-tmux $argv
  else
    command fzf $argv
  end
end
