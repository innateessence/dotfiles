#!/usr/bin/env zsh

# simple misc renames
alias py="python"
alias bpy="python -m bpython"
alias ppy="python -m ptpython"
alias ipy="python -m IPython"
alias http-status="hs"
alias cat="bat"
alias extract="untar"
alias markdown="glow"
alias luash="luap"
alias beep="printf '\a'"

# cd aliases
alias ~="cd ~"
alias ~~="cd $WORK_DIR"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias cd.="cd $DOTFILES_DIR"

# git aliases
alias git="hub"
alias gs="git status"
alias ga="git add"
alias gb="git branch | grep '*' | tr -d '* '" # print working branch
alias gp='__git_push'
alias gff="git pull --ff-only"
alias gopen="__open_repo"
alias branch="gb"
alias lspr="gh pr list --search 'review:required review-requested:@me'"
# alias propen="gh pr view --web" # TODO: Make this built on top of git

# Kitty kitten aliases
alias icat="kitty +kitten icat"

# ls aliases
alias ls='lsd --header --group-dirs first'
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
alias bashfoo="__browser_open https://tldp.org/LDP/abs/html/"
alias du-gui="ncdu"
alias hexdump="od -A x -t x1 -v"
alias Hexdump="sudo hexdump"
alias pip-upgrade-all="pip list --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias get-proxies="docker run --rm bluet/proxybroker2 find --types HTTP HTTPS --lvl High --countries US --strict -l 10 2>&1 | grep -o -E '\d+\.\d+\.\d+\.\d+\:\d+'"

# Music aliases
alias lofi='mpv --no-video "https://play.streamafrica.net/lofiradio"'
alias phonk='mpv --no-video "http://www.youtube.com/watch?v=ab-WFNS27co"'

# history aliases
alias clip!='history -n -1 | clip' # behaves as if `clip !!` worked. copies the last command into the clipboard
alias histgrep="history -n 0 | grep"
alias hist="history -n 0"
alias hgrep="histgrep"

# exit aliases
alias :q="exit 0"
alias bye="exit 0"

# fzf aliases (including homebrew fzff)
alias f="fzff | clip"
alias cdf="fzff_cd"
alias xf="fzf_exec"

# Editor aliases (LunarVim ftw)
alias lvim="lazyvim"
alias vi='lazyvim'
alias vim='lazyvim'
# alias nvim="lvim"
alias lvim!="sudo -E lazyvim"
alias vidiff='lazyvim -d'
alias vimdiff='lazyvim -d'
alias lvimdiff='lazyvim -d'

# Sudo alias
alias sudo="sudo -E" # preserve env by default.

# Programming language specific aliases
alias lspysig="ag --no-numbers -s -G '.py' '(def .+|class .+)' --color-match '0'" # ls python signatures

# ArchLinux specific aliases
if __is_arch_linux; then
    alias Pacman="sudo pacman"
    alias update-mirrors="sudo reflector --age 24 --country 'United States' --completion-percent 100 --protocol 'http,https' --fastest 20 --sort rate --number 5 --save /etc/pacman.d/mirrorlist"
    alias open="xdg-open"
    alias clip="xclip -i"
    alias missing-files="pacman -Qk 2>&1 | grep -E ', [1-9][0-9]* missing files'"
    # networking
    alias ip="ip -color -brief"
fi

if __is_ubuntu; then
    alias clip="xclip -i -selection clipboard"
fi

# MacOS specific aliases
if __is_mac; then
    alias clip="no-eol | pbcopy |  echo '[+] copied to clipboard'"
    alias python="python3"
    alias missing-files="brew missing"
    alias pip="pip3"
    alias throttle-on="sudo throttle --stop > /dev/null && throttle --down 2000 --up 1000 --rtt 0 --packetLoss 0"
    alias throttle-off="sudo throttle --stop"
    alias ls-app-store-apps="find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print |\sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'"
    alias cdtofinder="__cd_to_finder"
    alias hexedit="/Applications/ImHex.app/Contents/MacOS/imhex"
    alias x86_64="arch -x86_64 zsh"

    alias archlinux.wake="~/.dotfiles/scripts/wake-arch.sh"
    alias archlinux.on="archlinux.wake"

    alias archlinux.shutdown="archlinux.ssh 'sudo shutdown now'"
    alias archlinux.off="archlinux.shutdown"

    alias archlinux.suspend="archlinux.ssh 'sudo systemctl suspend'"
    alias archlinux.sleep="archlinux.suspend"
    alias archlinux.reboot="archlinux.wake &> /dev/null ; archlinux.ssh 'sudo reboot now'"
    alias archlinux.ssh="ssh archlinux"
    alias archlinux.vnc="echo 'Opening VNC GUI...' && /Applications/VNC\ Viewer.app/Contents/MacOS/vncviewer"

    alias fix-remote="ssh dakboard '~/fix-remote.sh'"
fi

# WSL specific aliases
if __is_wsl; then
    alias clip="clip.exe"
fi

if __is_ubuntu; then
    alias upgrade="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && flatpak update -y"
fi

# Unset aliases if the expected dependency doesn't exist in path
if ! command -v bpython  &> /dev/null && command -v bpy          &> /dev/null;  then unalias bpy         ; fi
if ! command -v bpython  &> /dev/null && command -v bpy          &> /dev/null;  then unalias bpy         ; fi
if ! command -v ptpython &> /dev/null && command -v ppy          &> /dev/null;  then unalias ppy         ; fi
if ! command -v hs       &> /dev/null && command -v http-status  &> /dev/null;  then unalias http-status ; fi
if ! command -v lsd      &> /dev/null && command -v ls           &> /dev/null;  then unalias ls          ; fi
if ! command -v bat      &> /dev/null && command -v cat          &> /dev/null;  then unalias cat         ; fi
if ! command -v glow     &> /dev/null && command -v markdown     &> /dev/null;  then unalias markdown    ; fi
if ! command -v hub      &> /dev/null && command -v git          &> /dev/null;  then unalias git         ; fi
if ! command -v gh       &> /dev/null && command -v lspr         &> /dev/null;  then unalias lspr        ; fi
if ! command -v gh       &> /dev/null && command -v propen       &> /dev/null;  then unalias propen      ; fi
if ! command -v kitty    &> /dev/null && command -v icat         &> /dev/null;  then unalias icat        ; fi
if ! command -v ip       &> /dev/null && command -v ip           &> /dev/null;  then unalias ip          ; fi
if ! command -v wget     &> /dev/null && command -v wget         &> /dev/null;  then unalias wget        ; fi
if ! command -v ncdu     &> /dev/null && command -v du-gui       &> /dev/null;  then unalias du-gui      ; fi
if ! command -v fzf      &> /dev/null && command -v f            &> /dev/null;  then unalias f           ; fi
if ! command -v fzf      &> /dev/null && command -v zf           &> /dev/null;  then unalias zf          ; fi
if ! command -v luap     &> /dev/null && command -v luash        &> /dev/null;  then unalias luash       ; fi
