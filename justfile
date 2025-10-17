switch:
  #!/bin/bash

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
      sudo darwin-rebuild switch --flake ./flake.nix

      if [ $? -eq 0 ]; then
        echo "Switch succeeded"
        
        # Source and destination directories
        SOURCE_DIR="/Applications/Nix Apps"
        DEST_DIR="/Applications"

        # Loop through each item in the source directory
        for app in "$SOURCE_DIR"/*; do
          if [ -d "$app" ]; then
            programName=$(basename "$app")
            sudo ln -s "$SOURCE_DIR/$programName" "$DEST_DIR/$programName"
            echo "Created symlink for $programName"
          fi
        done
      else
        echo "Switch failed"
      fi
    else
      sudo nixos-rebuild switch --flake ./flake.nix
    fi
  fi

push VAR="update":
  git add .
  git commit -m "{{VAR}}"
  git push
