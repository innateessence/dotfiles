#!/usr/bin/env zsh

# Pathing
export PATH="$HOME/.local/bin:$HOME/.gem/ruby/2.6.0/bin:$PATH:$HOME/.luarocks/bin"

# Misc Pathing
export DOTFILES_DIR="$HOME/.dotfiles"

# Default Directory
export DEFAULT_DIR="$HOME"

# Default Progs
export EDITOR='lvim'
export VISUAL='lvim'
export MANPAGER="sh -c 'col -bx | bat -l man --theme=default -p'"  # Use `bat` as pager (which uses less, but better)

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000  # 1 Mil lines for history. fzf is fast.
export SAVEHIST=$HISTSIZE

# Python
export PYTEST_ARGS="-n auto"

# fzf
export FZF_DEFAULT_OPTS="--layout=reverse --border"

# fzf unofficial (only custom functions use these.)
export FZF_DEFAULT_PREVIEW_CMD='bat'
export FZF_DEFAULT_PREVIEW_OPTS='--force-colorization --theme=TwoDark --line-range=:500'

# bat
# export BAT_THEME="TwoDark"

# Timeout values
export NETWORK_CHECK_SHELL_TIMEOUT=4  # Timeout value for functions that check various network access when run as a shell function

# Github (gh, hub)
export GITHUB_TOKEN="$(pass show personal/github/token/sudo)"

# WSL specific exports
if _is_wsl; then
  export DISPLAY="$(\ip route | awk '/^default/{print $3; exit}'):0"  # \ip to ignore the `ip` alias
  export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
fi


# Unset exports if the expected dependency doesn't exist in path
if ! command -v bat &> /dev/null; then unset MANPAGER                 ; fi
if ! command -v bat &> /dev/null; then unset FZF_DEFAULT_PREVIEW_CMD  ; fi
if ! command -v bat &> /dev/null; then unset FZF_DEFAULT_PREVIEW_OPTS ; fi
