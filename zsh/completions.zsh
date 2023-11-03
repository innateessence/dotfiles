#!/usr/bin/env zsh

#-------#
# fpath #
#-------#

if __is_mac && command -v brew &> /dev/null; then
    # MacOS
    brew_prefix=$(brew --prefix)
    FPATH=$brew_prefix/share/zsh-completions:$FPATH
    FPATH=$brew_prefix/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi

if __is_arch_linux; then
    # Arch Linux
    FPATH=/usr/share/zsh/site-functions/:$FPATH
    FPATH=/usr/share/fzf/completion.zsh:$FPATH

    autoload -Uz compinit
    compinit
fi
