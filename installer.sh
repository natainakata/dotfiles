#!/bin/bash

DOT_DIR="$HOME/.dotfiles"

has() {
  type "$1" > /dev/null 2>&1
}

if [ ! -d ${DOT_DIR} ]; then
  if has "git"; then
    git clone https://github.com/natainakata/dotfiles.git ${DOT_DIR}
  else
    echo "git required"
    exit 1
  fi
  cd ${DOT_DIR}

  if [ ! -d "$HOME/.config" ]; then
    mkdir -p "$HOME/.config"
  fi

	ln -snfv "$DOT_DIR/gitconfig" "$HOME/.gitconfig"
  ln -snfv "$DOT_DIR/zsh" "$HOME/.config/"
  ln -snfv "$DOT_DIR/zsh/zshrc" "$HOME/.zshrc"
  ln -snfv "$DOT_DIR/nvim" "$HOME/.config/"
  ln -snfv "$DOT_DIR/wezterm" "$HOME/.config/"
  ln -snfv "$DOT_DIR/systemd" "$HOME/.config/"
  ln -snfv "$DOT_DIR/xremap" "$HOME/.config/"
  ln -snfv "$DOT_DIR/lazygit" "$HOME/.config/"
  ln -snfv "$DOT_DIR/aqua" "$HOME/.config/"
  ln -snfv "$DOT_DIR/rtx" "$HOME/.config/"
  ln -snfv "$DOT_DIR/fish" "$HOME/.config/"
  ln -snfv "$DOT_DIR/tmux.conf" "$HOME/.tmux.conf"
  ln -snfv "$DOT_DIR/bin" "$HOME/.bin"

  if has "aqua"; then
    export AQUA_GLOBAL_CONFIG="$HOME/.config/aqua/aqua.yaml"
    aqua i -l -a
  else
    export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
    curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.0.0/aqua-installer
    echo "8299de6c19a8ff6b2cc6ac69669cf9e12a96cece385658310aea4f4646a5496d  aqua-installer" | sha256sum -c
    chmod +x aqua-installer
    ./aqua-installer
    export AQUA_GLOBAL_CONFIG="$HOME/.config/aqua/aqua.yaml"
    aqua i -l -a
  fi

else
  echo "dotfiles already exists"
  exit 1
fi
