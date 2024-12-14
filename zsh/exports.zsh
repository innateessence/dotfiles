#!/usr/bin/env zsh

# Pathing
export FS_UTILS_PATH="/opt/homebrew/opt/e2fsprogs" # Give me CLI tools for interacting with linux filesystems on MacOS
export LOCAL_PATH="$HOME/.local"                   # Misc local installs

export GO_PATH="$HOME/go"
export LUA_PATH="$HOME/.luarocks"
export RUBY_PATH="$HOME/.gem/ruby/2.6.0"
export HASKELL_PATH="$HOME/.ghcup"                 # GHC -> Haskell compiler / build tooling
export CARGO_PATH="$HOME/.cargo"                   # Rust
export ERG_PATH="$HOME/.erg"                       # Erg-lang. compiles to python bytecode.

export MASON_PATH="$HOME/.local/share/lvim/mason"  # Mason. My Lunarvim 'package manager' for custom LSP integrations.

export PATH="$PATH:$LOCAL_PATH/bin:$LUA_PATH/bin:$RUBY_PATH/bin:$MASON_PATH/bin:$HASKELL_PATH/bin:$CARGO_PATH/bin:$GO_PATH/bin:$ERG_PATH/bin:$FS_UTILS_PATH/sbin"

# Misc Pathing
export DOTFILES_DIR="$HOME/.dotfiles"
export WORK_DIR="$HOME/roadz"

# Compiler Options
# export CC="gcc"
# export CXX="g++"

# Default Directory
export DEFAULT_DIR="$HOME"

# VIRTUALENV (custom use only)
export DEFAULT_VIRTUALENV="default"

# JIRA (Custom use only)
export JIRA_URL="https://roadz-jira.atlassian.net"
export JIRA_DEFAULT_PROJECT="MARKET"

# Default Progs
export EDITOR='lvim'
export VISUAL='lvim'
 # NOTE: This is the MacOS version. Need to verify the new MANPAGER env var below plays nicely with MacOS.
# export MANPAGER="sh -c 'col -bx | bat -l man --theme=default -p'"
if __is_mac; then
    export MANPAGER="sh -c 'col -bx | bat -l man --theme=default -p'"
else
    export MANPAGER="sh -c 'bat -l man --theme=default -p'"   # Use `bat` as pager (which uses less, but better)
fi


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
# export GITHUB_TOKEN="$(pass show personal/github/token/sudo)"

# Pipenv
# export PIPENV_IGNORE_VIRTUALENVS=1  # Force pipenv to create it's own virtualenv instead of using the currently active virtualenv

# Aider
# export OPENAI_API_KEY="$(pass show chatgpt/aider)"

# WSL specific exports
if __is_wsl; then
    export DISPLAY="$(\ip route | awk '/^default/{print $3; exit}'):0"  # \ip to ignore the `ip` alias
    # export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" # TODO: Switch to Firefox if we ever use WSL again.
fi

# Unset exports if the expected dependency doesn't exist in path
if ! command -v bat &> /dev/null; then unset MANPAGER                 ; fi
if ! command -v bat &> /dev/null; then unset FZF_DEFAULT_PREVIEW_CMD  ; fi
if ! command -v bat &> /dev/null; then unset FZF_DEFAULT_PREVIEW_OPTS ; fi
