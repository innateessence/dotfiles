#!/usr/bin/env zsh

# This just houses wrappers built on top of existing functions/binaries/scripts
# Essentially, any function that houses the same namespace as an existing program goes here.
# And some that just wrap on top of an existing binary

function fzff(){
  # short for fzf files or fuzzy find files.
  # I like `fzf` to show me pretty previews of the files when run without args.
  # We assume that the only time we pipe input into fzf is to find files for this alias function.
  if [ $# -eq 0 ]; then
    command fzf --preview "$FZF_DEFAULT_PREVIEW_CMD $FZF_DEFAULT_PREVIEW_OPTS {}"
  else
    command fzf $@
  fi
}


function tmux(){
  # quickly either attach to existing tmux or spawn a new instance when run without args
  # otherwise, fallback to default `tmux` behavior
  if [ $# -eq 0 ]; then
    if tmux ls &>/dev/null; then
      command tmux attach -t 0
    else
      command tmux
    fi
  else
    command tmux "$@"
  fi
}

# Unset wrapper functions if the original binary doesn't exist in $PATH
if ! command -v tmux &> /dev/null; then unset -f tmux ; fi
if ! command -v fzf  &> /dev/null; then unset -f fzff ; fi
