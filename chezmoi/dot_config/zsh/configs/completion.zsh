#!/usr/bin/env zsh

# =========================================================== #
# Completion, managed by zinit
# =========================================================== #

# Zsh-completions
zinit ice wait'1' lucid as'program' id-as'zsh-completions' \
  atclone'
    mkdir -p ./completions

    # tldr(python-client)
    command_exists tldr && tldr --print-completion zsh > ${ZSH_COMPLETIONS_HOME}/_tldr || true

    # trash-cli
    local trash_cmds=(trash-empty trash-list trash-restore trash-put trash)
    for cmd in ${trash_cmds[@]}; do
      command_exists $cmd && $cmd --print-completion zsh > ${ZSH_COMPLETIONS_HOME}/_$cmd || true
    done

    cp -f ${ZSH_COMPLETIONS_HOME}/* ./completions/
    zinit creinstall -q .
  ' run-atpull atpull'%atclone'
zinit light zdharma-continuum/null
