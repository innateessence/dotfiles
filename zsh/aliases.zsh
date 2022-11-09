#!/usr/bin/env zsh

# simple misc renames
alias py="python"
alias bpy="python -m bpython"
alias ppy="python -m ptpython"
alias http-status="hs"
alias cat="bat"
alias extract="untar"
alias markdown="glow"
alias luash="luap"

# cd aliases
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd.="cd $DOTFILES_DIR"

# git aliases
alias git="hub"
alias gs="git status"
alias ga="git add"
alias gb="git branch | grep '*' | tr -d '* '" # print working branch
alias gff="git pull --ff-only"
alias gopen="_open_repo"
alias branch="gb"
alias lspr="gh pr list --search 'review:required review-requested:@me'"
alias propen="gh pr view --web"

# Kitty kitten aliases
alias icat="kitty +kitten icat"

# ls aliases
alias ls='lsd'
alias ll="ls -lh"
alias la="ls -lah"
alias sl='ls'
alias lschmod="ls -la --permission octal"
alias lsfuncs="declare -f | grep '() {' | tr -d ' {' | grep -v -E '^[[:space:]]' | grep -v -E '^_'"
alias lsprivfuncs="declare -f | grep '() {' | tr -d ' {' | grep -v -E '^[[:space:]]' | grep -E '^_'"

# mk-foo aliases
alias mkdir="mkdir -p"

# Misc aliases
alias mnt="mount | grep -E ^/dev | column -t | sort"
alias wget="wget -c" # resume downloads by default
alias bashfoo="_browser_open https://tldp.org/LDP/abs/html/"
alias du-gui="ncdu"
alias hexdump="od -A x -t x1z -v"

# history aliases
alias cp!='history -n -1 | clip' # `clip !!` copies the last command into the clipboard
alias histgrep="history -n 0 | grep"
alias hist="history -n 0"
alias hgrep="histgrep"

# exit aliases
alias :q="exit 0"
alias bye="exit 0"

# networking
alias ip="ip -color -brief"

# fzf aliases (including homebrew fzff)
alias f="fzff"
alias zf="fzff"

# Editor aliases (LunarVim ftw)
alias vi='lvim'
alias vim='lvim'
alias nvim='lvim'
alias lvim!="sudo -E lvim"
alias vidiff='lvim -d'
alias vimdiff='lvim -d'
alias lvimdiff='lvim -d'

# Sudo alias
alias sudo="sudo -E" # preserve env by default.

# ArchLinux specific aliases
if _is_arch_linux; then
  alias Pacman="sudo pacman"
  alias update-mirrors="sudo reflector --age 24 --country 'United States' --completion-percent 100 --protocol 'http,https' --fastest 20 --sort rate --number 5 --save /etc/pacman.d/mirrorlist"
  alias open="xdg-open"
  alias clip="xclip -i"
fi

# MacOS specific aliases
if _is_mac; then
  alias clip="pbcopy"
fi

# WSL specific aliases
if _is_wsl; then
  :
fi

# Unset aliases if the expected dependency doesn't exist in path
if ! command -v bpython   &> /dev/null;  then unalias ppy          ; fi
if ! command -v ptpython  &> /dev/null;  then unalias bpy          ; fi
if ! command -v hs        &> /dev/null;  then unalias http-status  ; fi
if ! command -v lsd       &> /dev/null;  then unalias ls           ; fi
if ! command -v bat       &> /dev/null;  then unalias cat          ; fi
if ! command -v glow      &> /dev/null;  then unalias markdown     ; fi
if ! command -v hub       &> /dev/null;  then unalias git          ; fi
if ! command -v gh        &> /dev/null;  then unalias lspr         ; fi
if ! command -v gh        &> /dev/null;  then unalias propen       ; fi
if ! command -v kitty     &> /dev/null;  then unalias icat         ; fi
if ! command -v ip        &> /dev/null;  then unalias ip           ; fi
if ! command -v wget      &> /dev/null;  then unalias wget         ; fi
if ! command -v ncdu      &> /dev/null;  then unalias du-gui       ; fi
if ! command -v fzf       &> /dev/null;  then unalias f            ; fi
if ! command -v fzf       &> /dev/null;  then unalias zf           ; fi
if ! command -v luap      &> /dev/null;  then unalias luash        ; fi
