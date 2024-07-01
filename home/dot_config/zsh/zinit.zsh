#!/usr/bin/env zsh

# =========================================================== #
# Zinit
# =========================================================== #

# Installation
declare -A ZINIT
export ZINIT[ZCOMPDUMP_PATH]="${XDG_CACHE_HOME}/zinit"
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Prompt & Theme
# =========================================================== #

# starship
zinit ice lucid as'program' from'gh-r' bpick'starship*.tar.gz' \
  atclone'./starship completions zsh > _starship' atpull'%atclone' pick'starship' \
  atinit'export STARSHIP_CONFIG=${XDG_CONFIG_HOME}/starship/config.toml' \
  atload'eval "$(starship init zsh)"'
zinit light starship/starship

# LS_COLORS
zinit ice lucid atclone'dircolors -b LS_COLORS > clrs.zsh' \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light trapd00r/LS_COLORS

# Plugins & snippets
# =========================================================== #

# OMZ libs & plugins
zinit wait lucid for \
    OMZL::functions.zsh \
    OMZL::grep.zsh \
    OMZP::extract \
    OMZP::colored-man-pages \
    OMZP::command-not-found \
  atinit'GLOBALIAS_FILTER_VALUES=(
    grep ls
  )' \
    OMZP::globalias

# history
zinit wait lucid for \
  atinit'HIST_STAMPS=yyyy-mm-dd' \
    OMZL::history.zsh \
    OMZP::history

# git
zinit wait lucid for \
  atinit'
    # https://github.com/ohmyzsh/ohmyzsh#disable-async-git-prompt
    zstyle ":omz:alpha:lib:git" async-prompt no
  ' \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::gitignore

# openssh
zinit ice wait'!' lucid atinit'
    SHORT_HOST=$HOST
    zstyle :omz:plugins:ssh-agent identities id_ed25519 id_gitsign
    zstyle :omz:plugins:ssh-agent quiet yes
  '
zinit snippet OMZP::ssh-agent

# sh-z
zinit ice wait lucid atinit'
    ZSHZ_DATA=${ZSH_CACHE_HOME}/.z
    ZSHZ_TILDE=1
  '
zinit light agkozak/zsh-z

# fast-syntax-highlighting
zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload'!_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# zsh-autopair
zinit ice wait lucid
zinit light hlissner/zsh-autopair

# Programs
# =========================================================== #

# --- chezmoi --- #

zinit ice wait lucid as'program' from'gh-r' bpick'chezmoi*.tar.gz' \
  atclone'./chezmoi completion zsh > _chezmoi' atpull'%atclone' pick'chezmoi'
zinit light twpayne/chezmoi

# --- go-task --- #

zinit ice wait lucid as'program' from'gh-r' bpick'task*.tar.gz' pick'task'
zinit light go-task/task

# --- age --- #

zinit ice wait lucid nocompletions as'program' from'gh-r' bpick'age*.tar.gz' pick'age/age*'
zinit light FiloSottile/age

# --- sops --- #

zinit ice wait lucid nocompletions as'program' from'gh-r' bpick'sops*' mv'sops* -> sops' pick'sops'
zinit light getsops/sops
