# Dotfiles

![Starts in 2024](https://img.shields.io/badge/Started-2024-brightgreen)

This repository is used to manage and track my personal configuration files,
managed with [chezmoi](https://github.com/twpayne/chezmoi).
By managing my dotfiles, I can easily set up a new development environment on any machine.

## Overview

### Features

- Support multiple OS: macOS, Debian, Ubuntu.
- Package Manager: Homebrew(macOS), Apt(Debian/Ubuntu).
- Shell: Zsh, Zinit(zsh plugin manager).
- asdf: The Multiple Runtime Version Manager.
  - Python
  - NodeJS
  - Golang

## Getting started

First installation you can use the [script](./install.sh) to install the dotfiles on your machine with a single command. Run the following command in your terminal:

```shell
# Include debug information in output
DOTFILES_DEBUG=1
# Enable `prompt*` functions
DOTFILES_PROMPT=1

# Install remotely by curl
DOTFILES_REMOTE=1 sh -c "$(curl -fsSL https://raw.githubusercontent.com/zikoengxi/dotfiles/main/install.sh)"
# Install remotely by wget
DOTFILES_REMOTE=1 sh -c "$(wget -qO- https://raw.githubusercontent.com/zikoengxi/dotfiles/main/install.sh)"
```

## LICENSE

[MIT](LICENSE)
