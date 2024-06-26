starship_config_dir="$ZSHRC_DIR/starship"
starship_cache="$starship_config_dir/starship.zsh"
export STARSHIP_CONFIG="$starship_config_dir/starship.toml"
if [[ ! -r "$starship_cache" || "$STARSHIP_CONFIG" -nt "$starship_cache" ]]; then
  starship init zsh --print-full-init > $starship_cache
fi
source $starship_cache
unset starship_cache starship_config_dir

mise_config="$XDG_CONFIG_HOME/mise/config.toml"
mise_cache="/tmp/mise_cache.zsh"
if [[ ! -r "$mise_cache" || "$mise_config" -nt "$mise_cache" ]]; then
  mise activate zsh > $mise_cache
fi
source $mise_cache
unset mise_cache mise_config

zoxide_cache="/tmp/zoxide_cache.zsh"
if [[ ! -r "$zoxide_cache" ]]; then
  zoxide init zsh --hook prompt > $zoxide_cache
fi
source $zoxide_cache
unset zoxide_cache

if [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ] && [ -n "${__ENABLE_TMUX}" ]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | fzf | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi
