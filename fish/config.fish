if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx XDG_DATA_HOME $HOME/.local/share
set -gx AQUA_ROOT_DIR $XDG_DATA_HOME/aquaproj-aqua
set -gx AQUA_GLOBAL_CONFIG $HOME/.config/aqua/aqua.yaml
set -gx PATH $AQUA_ROOT_DIR/bin $PATH

rtx activate fish | source
starship init fish | source


