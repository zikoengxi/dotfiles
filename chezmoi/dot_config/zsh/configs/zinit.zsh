#!/usr/bin/env zsh

# =========================================================== #
# Zinit
# =========================================================== #

# Installation
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# LS_COLORS
zinit ice atclone'dircolors -b LS_COLORS > clrs.zsh' \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light trapd00r/LS_COLORS

## OMZ libs and plugins
zinit wait lucid for \
    OMZL::functions.zsh \
    OMZL::grep.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZP::colored-man-pages \
    OMZP::command-not-found \
    OMZP::dirhistory \
    OMZP::extract \
  atinit'GLOBALIAS_FILTER_VALUES=(
    grep ls pip z
  )' \
    OMZP::globalias \
    OMZP::history

# Agkozak/zsh-z
zinit ice wait lucid atinit'ZSHZ_DATA=${ZSH_CACHE_HOME}/.z'
zinit light agkozak/zsh-z

# Fast-syntax-highlighting
zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting

# Zsh-autosuggestions
zinit ice wait lucid atload'!_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Zsh-autopair
zinit ice wait lucid
zinit light hlissner/zsh-autopair

# Zsh-completions
zinit ice wait lucid as'program' id-as'zsh-completions' \
  atclone'
    mkdir -p ./completions
    cp -f ${ZSH_HOME}/completions/* ./completions/
    zinit creinstall -q .
  ' run-atpull atpull'%atclone'
zinit light zdharma-continuum/null

# Theme: ys
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  zinit lucid for \
      OMZL::git.zsh \
      OMZL::prompt_info_functions.zsh \
      OMZT::ys
else
  zinit wait'!' lucid for \
      OMZL::git.zsh \
      OMZL::prompt_info_functions.zsh \
      OMZT::ys
fi

# Chezmoi
# =========================================================== #

zinit ice wait lucid as'program' from'gh-r' bpick'chezmoi*.tar.gz' pick'chezmoi'
zinit light twpayne/chezmoi

# Git
# =========================================================== #

zinit wait lucid for \
    OMZL::git.zsh \
  atload'unalias grv' \
    OMZP::git \
    OMZP::gitignore

# Lazygit
zinit ice wait lucid as'program' from'gh-r' bpick'lazygit*' pick"lazygit"
zinit light jesseduffield/lazygit

# Direnv
# =========================================================== #

zinit ice wait lucid as'program' from'gh-r' mv'direnv* -> direnv' \
  atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
  pick'direnv' src'zhook.zsh'
zinit light direnv/direnv

# ASDF, https://asdf-vm.com/guide/getting-started.html
# =========================================================== #

ASDF_CONFIG_HOME="${XDG_CONFIG_HOME}/asdf"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_CONFIG_FILE="${ASDF_CONFIG_HOME}/asdfrc"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-npm-packages"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-py-packages"
export ASDF_GOLANG_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-go-packages"

zinit ice wait lucid atinit'
    # python
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    # nodejs
    export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc
    export NPM_CONFIG_CACHE=${XDG_CACHE_HOME}/npm

    # golang
    export ASDF_GOLANG_MOD_VERSION_ENABLED=1
    [ -f ${ASDF_DATA_DIR}/plugins/golang/set-env.zsh ] && . ${ASDF_DATA_DIR}/plugins/golang/set-env.zsh || true
    export GOPATH="${XDG_DATA_HOME}/go"
  ' \
  pick'asdf.sh'
zinit light asdf-vm/asdf

zinit wait lucid for \
    OMZP::golang \
  atinit'mkdir -p ${XDG_CACHE_HOME}/pip' \
    OMZP::pip \
    OMZP::poetry-env \
    OMZP::python \
    OMZP::npm
