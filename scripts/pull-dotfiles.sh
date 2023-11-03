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
    /usr/bin/ssh-agent /bin/bash -c "ssh-add $HOME/.ssh/id_rsa && cd ~/.dotfiles && /usr/bin/git pull --ff-only"
}

function default_pull(){
    cd ~/.dotfiles && /usr/bin/git pull --ff-only
}

if _is_mac; then
    _mac_pull
else
    default_pull
fi
