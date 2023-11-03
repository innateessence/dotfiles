#!/bin/sh

CRON_ENV="/tmp/cron-env/$(whoami)"

# Mimic cron PATH
export OLD_PATH="$PATH"
export PATH=/usr/bin:/bin
# Execute the command as cron
exec /usr/bin/env -i `cat "$CRON_ENV"` "/bin/sh" -c "PATH=$PATH ; $*"

# Revert the PATH to avoid side effects in current shell session
export PATH="$OLD_PATH"
unset OLD_PATH
