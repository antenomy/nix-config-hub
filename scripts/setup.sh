#!/usr/bin/env bash
set -euo pipefail

if [ $(uname) == "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

bash ~/nix/scripts/just/switch.sh
