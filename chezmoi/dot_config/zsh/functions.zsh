#!/usr/bin/env zsh

# =========================================================== #
# Functions
# =========================================================== #

function command_exists() { command -v "$1" >/dev/null 2>&1; }

function is_os_macos() { [[ $OSTYPE = darwin* ]] }
