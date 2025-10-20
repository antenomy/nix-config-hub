{ pkgs ? import <nixpkgs> {} }:

let
  path = import ../nixos/config/paths.nix;
in # ERROR SOMEHOW
pkgs.writeShellApplication {
  name = "start-services";
  
  runtimeInputs = with pkgs; [
    docker
    procps
  ];
  
  text = ''
    sudo chown antenomy:users ${path.REPO}

    # Copy the old config directory to tmp for backup
    sudo cp -r /etc/nixos ${path.REPO_BACKUP_PATH}

    # Now copy the new config directory to the correct place
    sudo cp -r ${path.REPO}/nixos /etc/nixos

    echo "Building and switching to new configuration..."
    if sudo nixos-rebuild switch; then
        echo "Configuration updated successfully!"
        echo "Backup saved at: ${path.REPO_BACKUP_PATH}"
    else
        echo "nixos-rebuild failed! Restoring backup..."
        sudo rm -rf /etc/nixos
        sudo cp -r ${path.REPO_BACKUP_PATH} /etc/nixos
        echo "Backup restored. Please check the configuration and try again."
        exit 1
    fi

    # Restart homepage instance
    sudo systemctl restart homepage-dashboard

    echo "Deployment completed successfully!"
  '';
}