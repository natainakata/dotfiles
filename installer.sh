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
  ln -snfv "$DOT_DIR/starship.toml" "$HOME/.config/"
  ln -snfv "$DOT_DIR/nvim" "$HOME/.config/"
  ln -snfv "$DOT_DIR/wezterm" "$HOME/.config/"
  ln -snfv "$DOT_DIR/systemd" "$HOME/.config/"
  ln -snfv "$DOT_DIR/xremap" "$HOME/.config/"
  ln -snfv "$DOT_DIR/lazygit" "$HOME/.config/"
  ln -snfv "$DOT_DIR/aqua" "$HOME/.config/"
  ln -snfv "$DOT_DIR/tmux.conf" "$HOME/.tmux.conf"
  ln -snfv "$DOT_DIR/bin" "$HOME/.bin"
  ln -snfv "$DOT_DIR/zsh" "$HOME/.zsh"
  ln -snfv "$DOT_DIR/zshrc" "$HOME/.zshrc"
  ln -snfv "$DOT_DIR/zshenv" "$HOME/.zshenv"

  if [ ! has "aqua" ]; then
    curl -fsSL "https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.1.2/aqua-installer" | bash
  fi

else
  echo "dotfiles already exists"
  exit 1
fi
