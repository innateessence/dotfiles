#!/usr/bin/env zsh

# insert mode in vim behaves kinda like emacs with these bindings.
# emacs is a nice default but having vim-power directly in my shell on-demand by hitting [esc] is always great
# These bindings give me the best of both worlds.

# Personal Computer Keybind 'Corrections' (TMUX)
#
if __is_in_tmux; then
    #       vi-mode  escape-seq  widget                   keys            vi-mode
    # Jump to start/end of line
    bindkey -M viins '^[[1~' beginning-of-line           # Home             [I]
    bindkey -M viins '^[[4~' end-of-line                 # End              [I]
    bindkey -M vicmd '^[[1~' vi-beginning-of-line        # Home             [N]
    bindkey -M vicmd '^[[4~' vi-end-of-line              # End              [N]

    if __is_mac; then
        # NOTE: These are kitty terminal keybinds while using tmux. YMMV with different terminal emulators.
        # I really shouldn't use tmux + kitty at the same time, but oh well,
        # I can make it work better than how most people have things setup.

        # Jump backwards/forwards by a word.
        bindkey -M viins "\e[1;2C" forward-word          # Ctrl + Right     [I]
        bindkey -M viins "\e[1;2D" backward-word         # Ctrl + Left      [I]
        bindkey -M vicmd "\e[1;2C" vi-forward-word       # Ctrl + Right     [N]
        bindkey -M vicmd "\e[1;2D" vi-backward-word      # Ctrl + Left      [N]
        bindkey -M viins "\e[1;3C" forward-word          # Ctrl + Right     [I]
        bindkey -M viins "\e[1;3D" backward-word         # Ctrl + Left      [I]
        bindkey -M vicmd "\e[1;3C" vi-forward-word       # Ctrl + Right     [N]
        bindkey -M vicmd "\e[1;3D" vi-backward-word      # Ctrl + Left      [N]
    elif __is_wsl; then
        # NOTE: These are my Windows ArchWSL keybinds using the Windows Terminal

        # Jump backwards/forwards by a word.
        bindkey -M viins "\e[1;5C" forward-word          # Ctrl + Right     [I]
        bindkey -M viins "\e[1;5D" backward-word         # Ctrl + Left      [I]
        bindkey -M vicmd "\e[1;5C" vi-forward-word       # Ctrl + Right     [N]
        bindkey -M vicmd "\e[1;5D" vi-backward-word      # Ctrl + Left      [N]
    fi

    # Delete line after cursor position
    bindkey -M viins "^K" vi-kill-eol                    # Ctrl + K         [I]
    bindkey -M vicmd "^K" vi-kill-eol                    # Ctrl + K         [N]

    # Make Delete Key work
    bindkey -M viins "^[[3~" vi-delete-char              # Delete           [I]
    bindkey -M vicmd "^[[3~" vi-delete-char              # Delete           [N]

    # Make Insert Key switch between insert/normal mode
    bindkey -M vicmd "^[[2~" vi-insert                   # Insert           [N]
    bindkey -M viins "^[[2~" vi-cmd-mode                 # Insert           [I]

    # fzf files widget
    # zle -N fzff-widget "fzff"  # Create widget to exec custom fzff function. Needs modifications to work as a widget.
    bindkey -M viins '^F' 'fzf-file-widget'              # Ctrl + F         [I]
    bindkey -M vicmd '^F' 'fzf-file-widget'              # Ctrl + F         [N]

    # press 'v' in normal mode to edit current command   in $EDITOR
    autoload edit-command-line
    zle -N edit-command-line
    bindkey -M vicmd v edit-command-line                 # v                [N]
else
    # TODO: Add non-tmux keybinds here
    warn "Not in tmux, skipping tmux keybinds"
fi
