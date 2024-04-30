#!/bin/bash

DOT_DIR="$HOME/.dotfiles"

has() {
  type "$1" > /dev/null 2>&1
}

shim() {
  echo "Home Dir shim"
  home_files=(`ls -1 $DOT_DIR/home/`)
  for home_file in "${home_files[@]}"; do
    ln -snfv "$DOT_DIR/${home_file}" "$HOME/.${home_file}"
  done
  ln -snfv "$DOT_DIR/home/zsh/zshrc" "$HOME/.zshrc"
  echo "Done."

  echo "Config dir shim"
  if [ ! -d "$HOME/.config" ]; then
    echo "Create config dir"
    mkdir -p "$HOME/.config"
    echo "Done."
  fi

  config_files=(`ls -1 $DOT_DIR/config/`)
  for config_file in "${config_files[@]}"; do
    ln -snfv "$DOT_DIR/config/${config_file}" "$HOME/.config/"
  done
  echo "Done."
}

toolchain_install() {
  echo 'Toolchain install'
  if ! has "nix" ; then
    echo "Nix install"
    curl -L https://nixos.org/nix/install | sh
    echo "Done."
  fi
  cd $DOT_DIR/nix
  echo "Home Manager build"
  nix run nixpkgs#home-manager -- switch --flake ".#natai"
  echo "Done."
}

reinstall_wizerd() {
  echo "-----------------"
  echo "Reinstall? (Y/A/n)"
  read input
  if [ -z $input ] || [ $input = 'no' ] || [ $input = 'NO' ] || [ $input = 'n' ] ; then
    echo "quit."
    exit 1
  elif [ $input = 'all' ] || [ $input = 'ALL' ] || [ $input = 'a' ] ; then
    echo "All reinstall process start"
    cd $DOT_DIR
    git pull
    shim
    toolchain_install
    echo "Done."
    exit 0
  elif [ $input = 'yes' ] || [ $input = 'YES' ] || [ $input = 'y' ] ; then
    echo "Reinstall wizerd start"
    cd $DOT_DIR
    echo "Upstream pull? (Y/n)"
    read input
    if [ $input = 'yes' ] || [ $input = 'YES' ] || [ $input = 'y' ]; then
      git pull
      echo "Done."
    fi
    echo "Reshim? (Y/n)"
    read input
    if [ $input = 'yes' ] || [ $input = 'YES' ] || [ $input = 'y' ]; then
      shim
      echo "Done."
    fi
    echo "toolchain Reinstall? (Y/n)"
    read input
    if [ $input = 'yes' ] || [ $input = 'YES' ] || [ $input = 'y' ]; then
      toolchain_install
      echo "Done."
    fi
    echo "Done reinstall wizerd."
    exit 0
  fi
}

if [ ! -d ${DOT_DIR} ]; then
  echo "-----------------"
  echo "Dotfiles Installer"
  echo "-----------------"
  echo "Clone dotfiles repo"
  if has "git"; then
    git clone https://github.com/natainakata/dotfiles.git ${DOT_DIR}
  else
    echo "git required"
    exit 1
  fi
  shim
  toolchain_install
  echo "Installed!"
  exit 0
else
  echo "dotfiles already exists"
  reinstall_wizerd
fi
