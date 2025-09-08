{ pkgs ? import <nixpkgs> {} }:

let
  path = import ../nixos/config/paths.nix;
in
pkgs.writeShellApplication {
  name = "start-services";
  
  runtimeInputs = with pkgs; [
    cloudflared
    docker
    docker-compose
    procps      # for pgrep
    util-linux  # for nohup
    coreutils   # for date, tee, sleep, etc.
    gnugrep     # for grep
    git
    gawk 
  ];
  
  text = ''
    #!/bin/bash

    # Robust setup script with error handling
    set -e

    LOG_FILE="${path.SETUP_LOG_FILE}"

    log() {
        echo "$(date): $1" | tee -a "$LOG_FILE"
    }

    # Function to check if container is running
    check_container() {
        if docker ps --format "table {{.Names}}" | grep -q "^$1$"; then
            log "$1 is already running, stopping first..."
            docker stop "$1" && docker rm "$1"
        fi
    }

    log "Starting home lab services setup..."

    # Start Cloudflared Tunnel
    log "Starting Cloudflared tunnel..."
    if pgrep -f "cloudflared tunnel" > /dev/null; then
        log "Cloudflared already running"
    else
        nohup cloudflared tunnel run --token eyJhIjoiYTczOGQxOTU0NWVhN2NiYWIxYjY3N2IyODM3ZDViYzIiLCJ0IjoiNGY1YTg4NTYtODFlOC00YTFlLWIzZmUtYjQ5NWU2MDc1NTA5IiwicyI6Ik9HUTJOalUwTjJFdFptWXhPQzAwWlRoaExUZzBPVEV0TlRnNE1UVm1aVFEyWkRKbSJ9 > /var/log/cloudflared.log 2>&1 &
        sleep 5
    fi

    # Setup Portainer
    log "Setting up Portainer..."
    check_container "portainer"
    docker run -d \
    -p 8000:8000 \
    -p 9443:9443 \
    --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:lts

    # Start Pi-hole
    log "Starting Pi-hole..."
    if [ -d "/etc/nixos/pihole-docker" ]; then
        cd /etc/nixos/pihole-docker
        docker-compose up -d
    else
        log "ERROR: Pi-hole directory not found at /etc/nixos/pihole-docker"
        exit 1
    fi

    git config --global --add safe.directory /home/antenomy/nix-wyse-a22

    log "All services started successfully!"
    log "Access points:"
    log "- Portainer: https://localhost:9443"
    log "- Pi-hole: http://localhost/admin"

    # Show running containers
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
  '';
}