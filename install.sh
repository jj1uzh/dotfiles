#!/bin/bash -eu

skipped=""
install_link() {
    local path="$1"
    local target="$HOME/$path"
    echo "==> Install $path"
    if [ -f "$target" ]; then
        echo " -> ~/$path exists. Skip."
        skipped="$skipped $path"
        return
    fi
    ln -s "./$path" "$target"
}

install_link ".bashrc"

echo "Done."
if [ -n "$skipped" ]; then
    echo "Skipped: $skipped"
fi
