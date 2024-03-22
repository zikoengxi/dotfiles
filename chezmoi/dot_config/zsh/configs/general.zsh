#!/usr/bin/env zsh

# =========================================================== #
# General
# =========================================================== #

# Color
# =========================================================== #

# Makes color constants available
autoload -U colors
colors

# Set terminal type
export TERM="xterm-256color"

# Enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# Language
# =========================================================== #

if is_os_macos; then
  export LANG="en_US.UTF-8"
  export LC_ALL="${LANG}"
else
  export LANG="C.UTF-8"
  export LC_ALL="${LANG}"
fi

# Editor
# =========================================================== #

export EDITOR="vim"
export VISUAL="${EDITOR}"

# Aliases
# =========================================================== #

# List the PATH separated by new lines
alias lpath='echo $PATH | tr ":" "\n"'

# Operate directory
alias md="mkdir -p"
alias rd="rmdir"

# List directory contents
alias ls="ls --color=auto"
alias lsa="ls -lah"
alias l="ls -lah"
alias ll="ls -lh"
alias la="ls -lAh"

# Trash
alias rm="trash"
