#!/usr/bin/env zsh

function docker_rmi_dangling(){
    local DANGLING_IMAGES=($(docker images -a --filter=dangling=true -q | tr '\n' ' '))  # An array of dangling image ids
    for image in "${DANGLING_IMAGES[@]}"; do
        echo "[*] Removing image $image"
        docker rmi "$image"
    done
}
