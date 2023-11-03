#!/usr/bin/env zsh

# Keep track of directories when changing directories interactively
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
