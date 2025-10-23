#!/usr/bin/env bash
set -euo pipefail

# This will be moved to nix eventually
if [ "$(hostname)" = "aelin" ]; then
    mkdir -p ~/.config

    # Aerospace
    cp ./dotfiles/darwin/.aerospace.toml ~
    cp -r dotfiles/darwin/aerospace ~/.config
    aerospace reload-config

    # Sketchybar
    cp -r ./dotfiles/darwin/sketchybar ~/.config/

    echo "transferred configs for: $(hostname)"
else 
    echo "unrecognized hostname: $(hostname), or hostname hasnt been covered yet for dotfile transfer"
fi
