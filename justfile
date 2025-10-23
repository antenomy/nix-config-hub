# Variables
HOSTNAME:="$(hostname)"
SYSTEM:="$(uname)"

edit:
    #!/usr/bin/env bash
    vim machines/$HOSTNAME/default.nix

dotfiles:
    /bin/bash -c "~/nix/"

switch-simple:
    #!/usr/bin/env bash
    if [ "$SYSTEM" == "Darwin" ]; then
        sudo nixos-rebuild switch --flake .
    else
        sudo darwin-rebuild switch --flake .


switch:
    #!/usr/bin/env bash
    set -euo pipefail

    RECOGNIZED_HOSTNAMES=("aelin" "dorian" "manon" "lorcan" "elide" "lysandra")

    if [[ " ${RECOGNIZED_HOSTNAMES[@]} " =~ " $HOSTNAME " ]]; then
        echo "Found"
    else
        echo "Not found"
    fi

    if [ "$HOSTNAME" = "aelin" ]; then
        recognizeHostname=0
    elif [ "$HOSTNAME" = "dorian" ]; then  # change to dorian if needed
        recognizeHostname=0
    else
        echo "unrecognized hostname: $HOSTNAME"
    fi

    if [ "$recognizeHostname" = 1 ]; then
        if [ "$isDarwin" = 1 ]; then
            echo "running darwin-rebuild switch..."
            if sudo darwin-rebuild switch --flake .; then
                echo "switch succeeded"

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
            echo "running nixos-rebuild switch..."
            sudo nixos-rebuild switch --flake .
        fi
    fi

    # Update dotfiles
    just dotfiles

push VAR="update":
    #!/usr/bin/env bash
    git add .
    git commit -m "{{VAR}}"
    git push
