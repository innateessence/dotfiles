#!/usr/bin/env zsh

# This just houses wrappers built on top of existing functions/binaries/scripts
# Essentially, any function that houses the same namespace as an existing program goes here.
# And some that just wrap on top of an existing binary

function vf(){
  # vim fuzzy file
  local filename
  filename=$(fzff)
  if [ -n "$filename" ]; then
    lvim $filename
  fi
}

function cd(){
  # fuzzy find change directory
  if [ $# -eq 0 ]; then
    builtin cd "$(find -type d | fzf)"
  else
    builtin cd "$@"
  fi
}

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


function fzff_cd(){
    # short for change directory to fzf file.
    local target_dir=$(dirname $(fzff))
    if directory_exists $target_dir; then
        cd $target_dir
    fi
}

function fzf_exec(){
    # Short for fuzzy find exec
    # Searches shell history & executes the command
    local command=$(hist | fzf)
    __write_to_current_stdin $command
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
if ! command -v fzf  &> /dev/null; then unset -f fzff ; fi
if ! command -v fzf  &> /dev/null; then unset -f fzff_cd ; fi
if ! command -v fzf  &> /dev/null; then unset -f fzf_exec ; fi
if ! command -v tmux &> /dev/null; then unset -f tmux ; fi
