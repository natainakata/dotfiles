#path

set -x GOPATH $HOME/.go

set -x PATH $HOME/.bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/.deno/bin $PATH
set -x PATH $GOPATH/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH

source /home/natai/.asdf/asdf.fish

eval (starship init fish)
eval (zoxide init fish)

if test -z "$ZELLIJ" && status -l
  set ID (zellij list-sessions)
  if test "$ID" = "No active zellij sessions found."
    zellij
  else
    set create_new_session "Create_New_Session"
    set ID "$ID\n$create_new_session:"
    set ID (echo $ID | string split "\n" | string split " " | fzf | cut -d: -f1)
    if test "$ID" = "$create_new_session"
      zellij
    else if test -n "$ID"
      zellij attach $ID
    else
    end
  end
end
