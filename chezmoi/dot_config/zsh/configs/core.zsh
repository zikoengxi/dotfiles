#!/usr/bin/env zsh

# =========================================================== #
# Zsh Core Settings
# =========================================================== #

# Zsh Options.
# ref: # https://zsh.sourceforge.io/Doc/Release/Options.html
# =========================================================== #

# Changing Directories.
setopt auto_cd                  # Change To Directory Without Having To Type 'cd'.

# Completion.
setopt always_to_end            # Move Cursor To The End Of A Completed Word.
setopt auto_list                # Automatically List Choices On Ambiguous Completion.
setopt auto_menu                # Show Completion Menu On A Single Tab.
setopt auto_param_slash         # Add A Trailing Slash To Completed Symlinks.
unsetopt complete_aliases       # Don't Complete Aliases.
setopt complete_in_word         # Allow Completion Within A Word.
setopt glob_complete            # Perform Completion Globbing.
setopt list_packed              # The completion menu takes less space.
setopt list_rows_first          # Show rows first when completing.
unsetopt menu_complete          # Don't automatically Insert The First Matched Directory.

# Expansion and Globbing.
setopt brace_ccl                # Allow Brace Character Class List Expansion.
unsetopt case_glob              # Perform Case-Insensitive Globbing.
setopt extended_glob            # Enable Extended Globbing Operators.
setopt glob_dots                # Include Dot Files In Globbing.

# History.
HISTFILE="${ZSH_CACHE_HOME}/.zsh_history"   # Set The History File.
HISTSIZE=100000                             # Save 100000 Lines Of History Within The Shell.
SAVEHIST=50000                              # Save 50000 Lines Of History Within The History File.
setopt appendhistory notify                 # Append History To The History File When Exiting.
setopt bang_hist                            # Treat The '!' Character Specially During Expansion.
setopt inc_append_history                   # Write To The History File Immediately, Not When The Shell Exits.
setopt share_history                        # Share History Between All Sessions.
setopt hist_expire_dups_first               # Expire A Duplicate Event First When Trimming History.
setopt hist_ignore_dups                     # Do Not Record An Event That Was Just Recorded Again.
setopt hist_ignore_all_dups                 # Delete An Old Recorded Event If A New Event Is A Duplicate.
setopt hist_find_no_dups                    # Don't Display A Previously Found Event.
setopt hist_ignore_space                    # Don't Record An Event Starting With A Space.
setopt hist_save_no_dups                    # Don't Write A Duplicate Event To The History File.
setopt hist_verify                          # Don't Execute Immediately Upon History Expansion.
setopt extended_history                     # Show Timestamp In History.
setopt hist_reduce_blanks                   # Remove Superfluous Blanks Before Recording Entry.

# Input/Output.
unsetopt correct                # Turn Off Corrections.
unsetopt flow_control           # Disable Flow Control.
setopt interactive_comments     # Allow Comments In Interactive Shells.
setopt path_dirs                # Perform Path Search Even On Command Names With Slashes.
setopt rc_quotes                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.

# Job Control.
setopt auto_resume              # Attempt To Resume Existing Job Before Creating A New Process.
unsetopt bg_nice                # Don't Run All Background Jobs At A Lower Priority.
unsetopt check_jobs             # Don't Report On Jobs When Shell Exit.
unsetopt hup                    # Don't Kill Jobs On Shell Exit.
setopt long_list_jobs           # List Jobs In The Long Format By Default.
setopt notify                   # Report Status Of Background Jobs Immediately.

# Prompting.
setopt prompt_subst             # Enable Substitution In Prompt Strings.

# Zle.
unsetopt beep                   # Don't Beep On Errors.
setopt combining_chars          # Combine Zero-Length Punctuation Characters ( Accents ) With The Base Character.

# Zstyle
# =========================================================== #

# Load Completion System.
autoload -Uz compinit

# Completion
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{green}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZSH_CACHE_HOME}/.zcompcache"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' rehash true
