#!/usr/bin/env zsh

#==========================#
#                          #
#       Highlighting       #
#                          #
#==========================#

# zstyle :compinstall filename ~/.zshrc
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -gA ZSH_HIGHLIGHT_STYLES

# Aliases and functions
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'

# Comments
ZSH_HIGHLIGHT_STYLES[comment]="fg=white"

# Commands and builtins
ZSH_HIGHLIGHT_STYLES[command]="fg=green,bold"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=green,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=green,bold"

# Paths
ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'

# Globbing
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow,bold'

# Options and arguments
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=red'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=red'

ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=yellow"

# PATTERNS
ZSH_HIGHLIGHT_PATTERNS+=('rm -f*' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('rm * -f*' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('sudo *' 'fg=white,bold,bg=red')

#===============================#
#                               #
#             ZStyle            #
#                               #
#===============================#

# ignore completion to commands we don't have
zstyle ':completion:*:functions'             ignored-patterns '_*'

# format autocompletion style
zstyle ':completion:*:descriptions'          format "%{$c1%}%d%{$reset_color%}"
zstyle ':completion:*:corrections'           format "%{$c3%}%d%{$reset_color%}"
zstyle ':completion:*:messages'              format "%{$c1%}%d%{$reset_color%}"
zstyle ':completion:*:warnings'              format "%BSorry, no matches for: %d%b"
#zstyle ':completion:*:warnings'             format "%{$c1%}%d%{$reset_color%}"

# zstyle kill menu
zstyle ':completion:*:*:kill:*'              menu yes select
zstyle ':completion:*:kill:*'                force-list always
zstyle ':completion:*:*:kill:*:processes'    list-colors "=(#b) #([0-9]#)*=36=31"

zstyle ':completion:*'                       accept-exact '*(N)'
zstyle ':completion:*'                       separate-sections 'yes'
zstyle ':completion:*'                       list-dirs-first true
zstyle ':completion:*:default'               list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*'                       menu select=200
zstyle ':completion:*'                       use-perl=1
zstyle ':completion:*'                       squeeze-slashes true
zstyle ':completion:*:cd:*'                  ignore-parents parent pwd
zstyle ':completion:*:(all-|)files'          ignored-patterns '*.un~'
zstyle ':completion:*:*:kill:*:processes'    list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion::complete:*'             use-cache on
zstyle ':completion::complete:*'             cache-path ~/.zsh-cache
zstyle ':completion:*:processes'             command 'ps -axw'
zstyle ':completion:*:processes-names'       command 'ps -awxho command'
zstyle ':completion:*'                       matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:functions'             ignored-patterns '_*'
zstyle ':completion:*'                       group-name            ''
zstyle ':completion:*:*:(mplayer|vlc):*'           tag-order files
zstyle ':completion:*:*:(mplayer|vlc):*'           file-patterns   \
    '*.(rmvb|mkv|mpg|wmv|mpeg|avi|flv|mp3|mp4|flac|ogg):video' \
    '*:all-files' '*(-/):directories'
zstyle ':completion:*:*:(vim|nvim|rview|vimdiff|xxd):*:*files' \
    ignored-patterns '*~|*.(old|bak|zwc|viminfo|rxvt-*|zcompdump)|pm_to_blib|cover_db|blib|pyc|exe' \
    file-sort modification
zstyle ':completion:*:*:(vim|nvim|rview|vimdiff|xxd):*' \
    file-sort modification
zstyle ':completion:*:*:(vim|nvim|rview|vimdiff|xxd):*' \
    tag-order files
#zstyle ':completion:*:vim:*:directories' ignored-patterns \*
zstyle ':completion:*:*:(scp):*' \
    file-sort modification
zstyle ':completion:*:*:(cd):*:*files' ignored-patterns '*~' file-sort access
zstyle ':completion:*:*:(cd):*'        file-sort access
zstyle ':completion:*:*:(cd):*'        menu select
zstyle ':completion:*:*:(cd):*'        completer _history
zstyle ':completion:*:*:perl:*'        file-patterns '*'
zstyle ':completion:*:descriptions' \
    format $'%{- \e[38;5;137;1m\e[48;5;234m%}%B%d%b%{\e[m%}'
zstyle ':completion:*:warnings' \
    format $'%{No match for \e[38;5;240;1m%}%d%{\e[m%}'
zstyle ':completion:*:*:apvlv:*'             tag-order files
zstyle ':completion:*:*:apvlv:*'             file-patterns '*.pdf'
zstyle ':completion:most-accessed-file:*' match-original both
zstyle ':completion:most-accessed-file:*' file-sort access
zstyle ':completion:most-accessed-file:*' file-patterns '*:all\ files'
zstyle ':completion:most-accessed-file:*' hidden all
zstyle ':completion:most-accessed-file:*' completer _files
# zstyle ':completion:*:(scp|sftp|ftp|lftp):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
# zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr:IP\ address *'
# zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
# zstyle ':completion:*:(ssh|scp|ftp|sftp|lftp):*:hosts-host' ignored-patterns '*.*' loopback localhost loopback ip6-loopback localhost ip6-localhost broadcasthost
# zstyle ':completion:*:(ssh|scp|ftp|sftp|lftp):*:hosts-ipaddr' ignored-patterns '^<->.<->.<->.<->' '127.0.0.<->'
# zstyle ':completion:*:(ssh|scp|ftp|sftp|lftp):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'zstyle ':completion:*:(ssh|scp|ftp|sftp|lftp):*:users' ignored-patterns \
    #     adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
    #     dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
    #     hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
    #     mailman mailnull mldonkey mysql nagios \
    #     named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
    #     operator pcap postfix postgres privoxy pulse pvm quagga radvd \
    #     rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs
# zstyle ignore login-name that starts with '_'
# FIXME: This doesn't behave as expected.
zstyle ':completion:*:(ssh|scp|ftp|sftp|lftp):*:login-name' ignored-patterns '_*'

# On MacOS Sonoma 14.0+ the following line is super fast where the lines above as very slow...
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $(cat ~/.ssh/config | grep 'Host '  | awk '{s = s $2 " "} END {print s}')


## VCS
# vcs_info
zstyle ':vcs_info:*'                      enable git
# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{62}D%F{237}IRTY%f'  # display ¹ if there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%F{62}S%F{237}TAGED'    # display ² if there are staged changes
zstyle ':vcs_info:*' actionformats "${FMT_BRANCH}${FMT_ACTION}" "${FMT_PATH}"
zstyle ':vcs_info:*' formats       "${FMT_BRANCH}"              "${FMT_PATH}"
zstyle ':vcs_info:*' nvcsformats   ""                           "%~"

# zstyle show completion menu if 2 or more items to select
zstyle ':completion:*'                    menu select=2
