#!/usr/bin/env zsh

function generate_script_aliases(){
    # Usage: $(generate_script_aliases)      - Default
    # Usage: $(generate_script_aliases true) - Debug
    local SCRIPT_DIRS=("$HOME/.dotfiles/scripts" "$HOME/work/scripts")
    local EXTENSIONS=("sh" "py")
    local DEBUG=${1:-false}

    function __is_executable(){
        local file="$1"
        if [ -f "$file" ]; then
            if [ -x "$file" ]; then
                return 0
            fi
        fi
        return 1
    }

    function __is_sudo_alias(){
      # if the name starts with a capital letter, it's a sudo alias
      local alias_name="$1"
      local first_char=$(echo "$alias_name" | cut -c1)
      if [[ "$first_char" =~ [A-Z] ]]; then
          return 0
      fi
      return 1
    }

    function trim_file_ext(){
        local file="$1"
        echo "${file%.*}"
    }

    for script_dir in $SCRIPT_DIRS; do
        if [ -d "$script_dir" ]; then
            for ext in $EXTENSIONS; do
                for script in $(ls $script_dir/**/*.$ext); do
                    if __is_executable "$script"; then
                        local alias_name=$(basename $(trim_file_ext "$script"))
                        if __is_sudo_alias "$alias_name"; then
                            script="sudo $script"
                        fi
                        if $DEBUG; then
                            echo "alias $alias_name=\"$script\""
                        fi
                        alias $alias_name="$script"
                    fi
                done
            done
            if $DEBUG; then
                echo "[+] Generated aliases for $script_dir"
            fi
        fi
    done
}

generate_script_aliases $1
