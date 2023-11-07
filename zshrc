#!/usr/bin/env zsh
# tput cup $LINES

# aqua i -l -a
# sheldon lock --update

# eval "$(sheldon source)"
#

cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
config_dir=${XDG_CONFIG_HOME:-$HOME/.config}
sheldon_toml="$config_dir/sheldon/plugins.toml"
# キャッシュがない、またはキャッシュが古い場合にキャッシュを作成
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $cache_dir
  sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
unset cache_dir sheldon_cache config_dir sheldon_toml
# eval "$(starship init zsh)"
eval "$(rtx activate zsh)"
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load rc
ZSHHOME="${HOME}/.zsh"
ZSHCONFS=(
  "alias.zsh" \
  "completion.zsh" \
  "fzf.zsh" \
  "keybind.zsh" \
  "option.zsh" \
)
for zsh_conf in ${ZSHCONFS}; do
  zsh-defer source "${ZSHHOME}/${zsh_conf}"
done

#if [ -d $ZSHHOME -a -r $ZSHHOME -a \
#  -x $ZSHHOME ]; then
#  for i in $ZSHHOME/*; do
#    [[ ${i##*/} = *.zsh ]] &&
#      [ \( -f $i -o -h $i \) -a -r $i ] && . $i
#  done
#fi


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

