#!/bin/bash

cd "$1" || echo "[!] Invalid path supplied: $1"
/usr/bin/ssh-agent /bin/bash -c "/usr/bin/ssh-add $HOME/.ssh/id_rsa && /usr/bin/git add -A && /usr/bin/git commit -m \"$2\" && /usr/bin/git push && exit 0"
