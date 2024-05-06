#!/bin/bash -u

skipped=""
install_link() {
    local src_rel="$1"
    local src_abs=`realpath "$src_rel"`
    local target="$HOME/$src_rel"
    echo "==> Install $src_rel"
    existing_link_target=`readlink -n "$target"`
    if [ "$existing_link_target" = "$src_abs" ]; then
        echo " -> $src_rel is already installed."
	return
    fi
    if [ -f "$target" ]; then
        echo " -> $src_rel exists. Skip."
        skipped="$skipped $src_rel"
        return
    fi
    ln -s "$src_abs" "$target"
}

install_link ".bashrc"
install_link ".config/xremap/config.yaml"

if [ -n "$skipped" ]; then
    echo "\nSkipped: $skipped"
fi
