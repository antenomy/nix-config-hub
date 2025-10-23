#!/usr/bin/env bash
set -euo pipefail

if [ "$(uname)" = "Darwin" ]; then
    echo "running darwin-rebuild switch..."
    if sudo darwin-rebuild switch --flake .; then
        echo "switch succeeded"
        
        # Update Symlinks
        SOURCE_DIR="/Applications/Nix Apps"
        DEST_DIR="/Applications"

        for app in "$SOURCE_DIR"/*; do
            if [ -d "$app" ]; then
                programName=$(basename "$app")
                sudo ln -sf "$SOURCE_DIR/$programName" "$DEST_DIR/$programName"
                echo "Created symlink for $programName"
            fi
        done

        bash ~/nix/scripts/just/update-dotfiles.sh
    else
        echo "switch failed"
    fi
else
    echo "running nixos-rebuild switch..."
    if sudo nixos-rebuild switch --flake .; then
        echo "switch succeeded"
        bash ~/nix/scripts/just/update-dotfiles.sh
    else
        echo "switch failed"
    fi
fi
