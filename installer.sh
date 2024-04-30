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
  if not has "nix"; then
    echo "Nix install"
    curl -L https://nixos.org/nix/install | sh
    echo "Done."
  fi
  cd $DOT_DIR/nix
  echo "Home Manager build"
  nix run nixpkgs#home-manager -- switch --flake ".#natai"
  echo "Done."
  # if has "aqua"; then
  #   export AQUA_GLOBAL_CONFIG="$HOME/.config/aqua/aqua.yaml"
  #   aqua i -l -a
  # else
  #   export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
  #   curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.0.0/aqua-installer
  #   echo "8299de6c19a8ff6b2cc6ac69669cf9e12a96cece385658310aea4f4646a5496d  aqua-installer" | sha256sum -c
  #   chmod +x aqua-installer
  #   ./aqua-installer
  #   export AQUA_GLOBAL_CONFIG="$HOME/.config/aqua/aqua.yaml"
  #   aqua i -l -a
  # fi
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
    git clone --branch test-installer https://github.com/natainakata/dotfiles.git ${DOT_DIR}
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
