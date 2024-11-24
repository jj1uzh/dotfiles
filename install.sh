#!/bin/bash -u

skipped=""
install_link() {
    local src_rel="$1"
    local src_abs=`realpath "$src_rel"`
    local target="$HOME/$src_rel"
    local target_dir=`dirname "$target"`
    existing_link_target=`readlink -n "$target"`
    if [ "$existing_link_target" = "$src_abs" ]; then
#        echo "Already installed"
	    return
    fi
    if [ -f "$target" ]; then
        echo "$src_rel: Exists"
        skipped="$skipped $src_rel"
        return
    fi
    mkdir -p "$target_dir"
    ln -s "$src_abs" "$target"
    echo '$src_rel: Installed'
}

install_link ".bashrc"
for f in $(find .config -type f); do
    install_link "$f"
done
for f in $(find .emacs.d -type f); do
    install_link "$f"
done


if [ -n "$skipped" ]; then
    echo "\nSkipped: $skipped"
fi
