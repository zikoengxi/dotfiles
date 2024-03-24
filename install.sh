#!/usr/bin/env bash

# -e: exit on error
# -u: exit on unset variables
set -eu

if [[ $OSTYPE = darwin* ]]; then
  # Install Xcode Command Line Tools
  if [[ ! -d $(xcode-select -p) ]]; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
  fi
fi

if ! chezmoi="$(command -v chezmoi)"; then
  bin_dir="${HOME}/.local/bin"
  chezmoi="${bin_dir}/chezmoi"
  echo "Installing chezmoi to '${chezmoi}'" >&2
  if command -v curl >/dev/null; then
    chezmoi_install_script="$(curl -fsSL https://chezmoi.io/get)"
  elif command -v wget >/dev/null; then
    chezmoi_install_script="$(wget -qO- https://chezmoi.io/get)"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
  sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
  unset chezmoi_install_script bin_dir
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

set -- init "$@"

if [ -n "${DOTFILES_REMOTE-}" ]; then
  set -- "$@" --apply zikoengxi
else
  set -- "$@" --apply --source="${script_dir}"
fi

if [ -n "${DOTFILES_DEBUG-}" ]; then
  set -- "$@" --debug
fi

echo "Running 'chezmoi $*'" >&2

# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
