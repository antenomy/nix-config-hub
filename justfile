# justfile

# Default variable
VAR := "update"

switch:
    #!/usr/bin/env bash
    set -euo pipefail

    HOSTNAME="$(hostname)"
    recognizeHostname=0
    isDarwin=0

    if [ "$HOSTNAME" = "aelin" ]; then
        path="/etc/nix-darwin"
        recognizeHostname=1
        isDarwin=1
    elif [ "$HOSTNAME" = "nixos" ]; then  # change to dorian if needed
        path="/etc/nixos"
        recognizeHostname=1
    else
        echo "unrecognized hostname: $HOSTNAME"
    fi

    if [ "$recognizeHostname" = 1 ]; then
        if [ "$isDarwin" = 1 ]; then
            echo "Running darwin-rebuild switch..."
            if sudo darwin-rebuild switch --flake .; then
                echo "Switch succeeded"

                SOURCE_DIR="/Applications/Nix Apps"
                DEST_DIR="/Applications"

                for app in "$SOURCE_DIR"/*; do
                    if [ -d "$app" ]; then
                        programName=$(basename "$app")
                        sudo ln -sf "$SOURCE_DIR/$programName" "$DEST_DIR/$programName"
                        echo "Created symlink for $programName"
                    fi
                done
            else
                echo "Switch failed"
            fi
        else
            echo "Running nixos-rebuild switch..."
            sudo nixos-rebuild switch --flake ./flake.nix
        fi
    fi

push VAR="update":
    git add .
    git commit -m "{{VAR}}"
    git push

dot:
    #!/usr/bin/env bash
    set -euo pipefail

    HOSTNAME="$(hostname)"
    recognizeHostname=0
    isDarwin=0

    if [ "$HOSTNAME" = "aelin" ]; then
        mkdir -p ~/.config

        # Aerospace
        cp ./dotfiles/darwin/.aerospace.toml ~
        aerospace reload-config

        cp -r ./dotfiles/darwin/sketchybar ~/.config/
        echo "Copied macOS configs"
    else 
        echo "unrecognized hostname: $HOSTNAME"
    fi