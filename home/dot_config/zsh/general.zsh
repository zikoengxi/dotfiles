#!/usr/bin/env zsh

# =========================================================== #
# Functions
# =========================================================== #

function is_darwin() {[[ $OSTYPE = darwin* ]]; }

function is_command() { command -v "$1" >/dev/null 2>&1; }

# =========================================================== #
# Package Manager
# =========================================================== #

# Homebrew
# =========================================================== #

if is_darwin; then
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    # For ARM macOS
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  if is_command brew; then
    # https://docs.brew.sh/Manpage#environment
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1

    # Coreutils
    export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
    # File-formula
    export PATH="${HOMEBREW_PREFIX}/opt/file-formula/bin:$PATH"
    # Gnu-tar
    export PATH="${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin:$PATH"
    # Gnu-sed
    export PATH="${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin:$PATH"
  fi
fi

# =========================================================== #
# General
# =========================================================== #

# Set terminal type
export TERM="xterm-256color"

# Language
export LANG="en_US.UTF-8"

# Editor
export EDITOR="vim"
export VISUAL="${EDITOR}"

# Commands
# =========================================================== #

# less
less_opts=(
  # Quit if entire file fits on first screen.
  -FX
  # Do not complain when we are on a dumb terminal.
  --dumb
  # Ignore case in searches that do not contain uppercase.
  --ignore-case
  # Allow ANSI colour escapes, but no other escapes.
  --RAW-CONTROL-CHARS
  # Quiet the terminal bell. (when trying to scroll past the end of the buffer)
  --quiet
)
export PAGER="less"
export LESS="${less_opts[@]}"
export LESSHISTFILE="${XDG_CACHE_HOME}/.lesshst"
export LESSHISTSIZE=65535

# gawk
is_command gawk && alias awk="gawk"

# Aliases
# =========================================================== #

# List the PATH separated by new lines
alias lpath='echo ${PATH} | tr ":" "\n"'

# Operate directory
alias md="mkdir -p"
alias rd="rmdir"

# List directory contents
alias ls="ls --color=auto -v"
alias l="ls -lah"
alias ll="ls -lh"
alias la="ls -lAh"
