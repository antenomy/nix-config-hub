# Default variable
VAR := "update"

edit:
    HOSTNAME="$(hostname)"
    vim machines/$HOSTNAME/default.nix

dot:
    #!/usr/bin/env bash
    set -euo pipefail

    recognizeHostname=0
    isDarwin=0

    if [ "$HOSTNAME" = "aelin" ]; then
        mkdir -p ~/.config

        # Aerospace
        cp ./dotfiles/darwin/.aerospace.toml ~
        cp -r dotfiles/darwin/aerospace ~/.config
        aerospace reload-config

        cp -r ./dotfiles/darwin/sketchybar ~/.config/
        echo "Copied macOS configs"
    else 
        echo "unrecognized hostname: $HOSTNAME"
    fi
switch-simple:
    sudo nixos-rebuild switch --flake .

switch:
    #!/usr/bin/env bash
    set -euo pipefail

    HOSTNAME="$(hostname)"
    recognizeHostname=0
    isDarwin=0

    if [ "$HOSTNAME" = "aelin" ]; then
        recognizeHostname=1
        isDarwin=1
    elif [ "$HOSTNAME" = "dorian" ]; then  # change to dorian if needed
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
        elif  [ "$HOSTNAME" = "dorian" ]; then 
            echo "Running nixos-rebuild switch..."
            sudo nixos-rebuild switch --flake .
        fi
    fi

    # Update dotfiles
    just dot

push VAR="update":
    git add .
    git commit -m "{{VAR}}"
    git push
