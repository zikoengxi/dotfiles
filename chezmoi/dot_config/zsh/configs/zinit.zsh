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

# SSH agent
identities=()
filenames=(id_ed25519 id_git)
for filename in ${filenames[@]}; do
  if [[ -f ${HOME}/.ssh/${filename} ]]; then
    identities+=(${filename})
  fi
done
zstyle :omz:plugins:ssh-agent identities ${identities}
zstyle :omz:plugins:ssh-agent lifetime 168h
zstyle :omz:plugins:ssh-agent quiet yes
zinit ice wait lucid atinit'SHORT_HOST=$HOST'
zinit snippet OMZP::ssh-agent

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

zinit ice wait lucid as'program' from'gh-r' bpick'chezmoi*.tar.gz' \
  atclone'./chezmoi completion zsh > _chezmoi' atpull'%atclone' pick'chezmoi'
zinit light twpayne/chezmoi

# Git
# =========================================================== #

zinit wait lucid for \
    OMZL::git.zsh \
  atload'unalias grv' \
    OMZP::git \
    OMZP::gitignore

# Lazygit
zinit ice wait lucid nocompletions as'program' from'gh-r' bpick'lazygit*' pick'lazygit'
zinit light jesseduffield/lazygit

# Rclone
# =========================================================== #

zinit ice wait lucid as'program' from'gh-r' bpick'rclone*.zip' mv'rclone* -> rclone' \
  atclone'./rclone/rclone completion zsh - > _rclone' atpull'%atclone' pick'rclone/rclone'
zinit light rclone/rclone

# ripgrep
# =========================================================== #

zinit ice wait lucid as'program' from'gh-r' bpick'ripgrep*' mv'ripgrep* -> ripgrep' pick'ripgrep/rg'
zinit light BurntSushi/ripgrep

# jq
# =========================================================== #

zinit ice wait lucid as'program' from'gh-r' bpick'jq*' mv'jq* -> jq' pick'jq'
zinit light jqlang/jq

# yq
# =========================================================== #

zinit ice wait lucid as'program' from'gh-r' bpick'yq*' mv'yq* -> yq' \
  atclone'./yq shell-completion zsh > _yq' atpull'%atclone' pick'yq'
zinit light mikefarah/yq

# go-task
# =========================================================== #

zinit ice wait lucid as'program' from'gh-r' bpick'task*' pick'task'
zinit light go-task/task

# age
# =========================================================== #

zinit ice wait lucid nocompletions as'program' from'gh-r' bpick'age*' pick'age/age*'
zinit light FiloSottile/age

# sops
# =========================================================== #

zinit ice wait lucid nocompletions as'program' from'gh-r' bpick'sops*' mv'sops* -> sops' pick'sops'
zinit light getsops/sops

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

# pulumi
# =========================================================== #

zinit ice lucid as'program' from'gh-r' bpick'pulumi*' \
  atclone'./pulumi/pulumi gen-completion zsh > _pulumi' atpull'%atclone' pick'pulumi/*'
zinit light pulumi/pulumi

# docker
# =========================================================== #

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# docker-compose
zinit ice wait lucid as'program' from'gh-r' bpick'docker-compose*' \
  mv'docker-compose* -> docker-compose'
zinit light docker/compose

zinit ice wait lucid
zinit snippet OMZP::docker-compose/_docker-compose

# lazydocker
zinit ice wait lucid nocompletions as'program' from'gh-r' bpick'lazydocker*' pick'lazydocker'
zinit light jesseduffield/lazydocker

# k8s
# =========================================================== #

# kubectl
zplugin ice wait lucid as'program' id-as'kubernetes-kubectl' atclone'
    curl -L https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/$(uname | tr "[:upper:]" "[:lower:]")/$(uname -m)/kubectl -o ./kubectl
    chmod +x ./kubectl
    ./kubectl completion zsh > _kubectl
    zinit creinstall -q .
  ' run-atpull atpull'%atclone' pick'kubectl'
zinit light zdharma-continuum/null

# k9s
zinit ice wait lucid nocompletions as'program' from'gh-r' bpick'k9s*' pick'k9s'
zinit light derailed/k9s
