# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# 
tput cup $LINES

ZINITHOME="$HOME/.zinit"
### Added by Zinit's installer
if [[ ! -f $ZINITHOME/bin/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p $ZINITHOME && command chmod g-rwX $ZINITHOME
    command git clone https://github.com/zdharma-continuum/zinit "$ZINITHOME/bin" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$ZINITHOME/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-bin-gem-node
### End of Zinit's installer chunk

source $ZINITHOME/bin/zinit.zsh

zinit ice wait lucid atload'_zsh_autosuggest_start'; zinit light zsh-users/zsh-autosuggestions
zinit ice wait'0' blockf atpull'zinit creinstall -q .'; zinit light zsh-users/zsh-completions
autoload -Uz compinit; compinit
zinit ice wait'0'; zinit light zdharma-continuum/fast-syntax-highlighting
zinit light chrissicool/zsh-256color
zinit light b4b4r07/emoji-cli
# zinit light b4b4r07/enhancd
zinit light supercrabtree/k
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"; zinit light sharkdp/bat
zinit ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"; zinit light sharkdp/fd
zinit ice as"program" from"gh-r" pick"lsd*/lsd"; zinit light Peltoche/lsd
zinit ice as"program" from"gh-r" mv"hexyl* -> hexyl" pick"hexyl/hexyl"; zinit light sharkdp/hexyl
zinit ice as"program" from"gh-r" pick"delta*/delta"; zinit light dandavison/delta
zinit wait'1' lucid \
  from"gh-r" as"program" mv"tealdeer-* -> tldr" pick"tldr" \
  light-mode for @dbrgn/tealdeer
zinit ice wait'1' lucid as"completion" mv'zsh_tealdeer -> _tldr'
zinit ice as"program" from"gh-r" \
  pick"zoxide*/zoxide" \
  atload'eval "$(zoxide init zsh)"'
zinit light ajeetdsouza/zoxide
zinit ice as"program" from"gh-r" \
  pick"starship*/starship" \
  atload'eval "$(starship init zsh)"'
zinit light starship/starship
# zinit light rupa/z
zinit ice from"gh-r" as"program"; zinit load junegunn/fzf-bin
zinit ice lucid wait'0' as"program" from"gh-r" \
  pick"pmy*/pmy" \
  atload'eval "$(pmy init)"'
zinit light relastle/pmy
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh

# load rc
ZSHHOME="${HOME}/.zsh"
if [ -d $ZSHHOME -a -r $ZSHHOME -a \
  -x $ZSHHOME ]; then
  for i in $ZSHHOME/*; do
    [[ ${i##*/} = *.zsh ]] && 
      [ \( -f $i -o -h $i \) -a -r $i ] && . $i
  done
fi

fpath=(~/.zsh/functions/*(N-/) $fpath)

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)


BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
[ -s "$BASE16_SHELL/profile_helper.sh" ] && \
eval "$("$BASE16_SHELL/profile_helper.sh")"

service docker status > /dev/null 2>&1
if [ $? = 1 ]; then
    sudo service docker start
fi
