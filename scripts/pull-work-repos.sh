#!/usr/bin/env bash

WORK_DIR="$HOME/roadz"
DIRS=("marketplace-saleor" "unified-application-suite")

#!/usr/bin/env bash
#
# TODO: MacOS edgecase handling for cron


function _is_equal () {
    test $1 = $2
}

function _is_mac () {
    _is_equal $(uname -s) "Darwin"
}

function _mac_pull(){
    ssh-agent bash -c "ssh-add $HOME/.ssh/id_rsa && git pull --ff-only"
}

function default_pull(){
    git pull --ff-only
}


for dir in "${DIRS[@]}"; do
    cd "$WORK_DIR/$dir" || echo "Error changing directory to $WORK_DIR/$dir"
    if _is_mac; then
        _mac_pull
    else
        default_pull
    fi
    if [ $? -ne 0 ]; then
        echo "[!] Error syncing $dir"
    else
        echo "[+] Synced $dir"
    fi
done
