#!/usr/bin/env bash

ZSH_COMPLETIONS_DIR="${HOME}/.config/zsh/completions"

# poetry
# poetry completions zsh > ${ZSH_COMPLETIONS_DIR}/_poetry

# tldr(python-client)
tldr --print-completion zsh > ${ZSH_COMPLETIONS_DIR}/_tldr

# trash-cli
cmds=(trash-empty trash-list trash-restore trash-put trash)
for cmd in ${cmds[@]}; do
  $cmd --print-completion zsh > ${ZSH_COMPLETIONS_DIR}/_$cmd
done
