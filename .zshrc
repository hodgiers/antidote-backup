#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Zsh options.
setopt extended_glob          # treat #, ~, and ^ as part of patterns for filename generation
setopt append_history         # this is default, but set for share_history
setopt hist_expire_dups_first # # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_find_no_dups      # When searching history don't show results already cycled through twice
setopt hist_ignore_dups       # Do not write events to history that are duplicates of previous events
setopt hist_ignore_space      # remove command line from history list when first character is a space
setopt hist_reduce_blanks     # remove superfluous blanks from history items
setopt inc_append_history     # save history entries as soon as they are entered
setopt interactivecomments    # allow use of comments in interactive code (bash-style comments)
setopt longlistjobs           # display PID when suspending processes as well
setopt share_history          # share history between different instances of the shell
HISTFILE=${HOME}/.local/share/zsh/history
HISTSIZE=100000
SAVEHIST=${HISTSIZE}


# Autoload functions you might want to use with antidote.
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/.functions}
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(.:t)
eval "$(direnv hook zsh)"

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load
autoload -Uz compinit && compinit

eval "bindkey "$terminfo[kcuu1]" history-substring-search-up"
eval "bindkey "$terminfo[kcud1]" history-substring-search-down"
MAGIC_ENTER_OTHER_COMMAND='ls -ltra .'
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
eval "$(op completion zsh)"; compdef _op op
#
