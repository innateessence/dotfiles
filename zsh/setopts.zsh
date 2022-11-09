#!/usr/bin/env zsh


#-----#
# Zle #                          # Zsh Line Editor
#-----#
bindkey -v                       # Use Vi-like bindings for shell (if zle is enabled) [bindkey is recommended interface]

#--------------#
# Input/Output #
#--------------#
setopt INTERACTIVE_COMMENTS      # Allows the use of comments in the interactive shell

#-----------#
# Globbing  #
#-----------#
setopt GLOBSTARSHORT             # Treats ** recursively. IE: `ls **/*.zsh` will list all files ending with .zsh within nested directories.

#-------------#
# Directories #
#-------------#

setopt AUTO_CD                   # Automatically CD into directory if invalid `command` but valid directory
setopt AUTO_PUSHD                # Make cd push the old directory onto the directory stack.

#---------#
# History #
#---------#

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
# setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
setopt HIST_ALLOW_CLOBBER        # Add `|' to output redirections in the history.

#---------------------#
# Scripts & Functions #
#---------------------#

setopt C_BASES                   # Hex and Octal numbers will be represented in the proper syntax. (0xFF / 0777)
