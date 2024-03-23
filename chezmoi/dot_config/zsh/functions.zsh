#!/usr/bin/env zsh

# =========================================================== #
# Functions
# =========================================================== #

function command_exists() { command -v "$1" >/dev/null 2>&1; }

function is_os_macos() { [[ $OSTYPE = darwin* ]] }

# ASDF
# =========================================================== #

function asdf_global_python() {
  ! command_exists asdf && (echo -e "Command 'asdf' not found!"; return 1)

  asdf plugin add python https://github.com/asdf-community/asdf-python.git

  # Install python
  PYTHON_VERSION='3.10.12'
  if [[ $# -eq 1 ]]; then
    PYTHON_VERSION=$1
  fi
  asdf install python ${PYTHON_VERSION}
  asdf global python ${PYTHON_VERSION}

  # Upgrade pip to latest
  pip install --upgrade pip
}

function asdf_global_nodejs() {
  ! command_exists asdf && (echo -e "Command 'asdf' not found!"; return 1)

  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

  # Install nodejs
  NODEJS_VERSION='20.11.1'
  if [[ $# -eq 1 ]]; then
    NODEJS_VERSION=$1
  fi
  asdf install nodejs ${NODEJS_VERSION}
  asdf global nodejs ${NODEJS_VERSION}

  # Upgrade npm to latest
  npm install -g npm

  # Use pnpm as default package manager
  corepack enable pnpm
}

function asdf_global_go() {
  ! command_exists asdf && (echo -e "Command 'asdf' not found!" return 1)

  asdf plugin add golang https://github.com/asdf-community/asdf-golang.git

  # Install golang
  GOLANG_VERSION='1.22.1'
  if [[ $# -eq 1 ]]; then
    GOLANG_VERSION=$1
  fi
  asdf install golang ${GOLANG_VERSION}
  asdf global golang ${GOLANG_VERSION}

  # fix: Get any new shims
  asdf reshim golang
}
