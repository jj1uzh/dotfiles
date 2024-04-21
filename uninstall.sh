#!/bin/bash -e

uninstall_link() {
    local path="$1"
    local target="$HOME/$path"
    echo "==> Uninstall $path"
    if [ ! -f "$target" ]; then
        echo " -> ~/$path does not exist. Skip."
        return
    fi
    rm -f "$target"
}

uninstall_link ".bashrc"

echo "Done."
