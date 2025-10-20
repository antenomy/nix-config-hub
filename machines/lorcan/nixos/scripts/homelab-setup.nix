{ pkgs ? import <nixpkgs> {} }:

# let
#   path = import "/etc/nixos/config/paths.nix";
# in
pkgs.writeShellApplication {
  name = "start-services";
  
  runtimeInputs = with pkgs; [
    cloudflared
    docker
    procps
  ];
  
  text = ''
    # Start Cloudflared Tunnel (in background)
    

    # Start Portainer Docker Container
    docker start portainer

    # Start Pi-hole Docker Container
    docker start pihole

    # Check status of all services
    echo "Checking service status..."
    echo "Cloudflared processes:"
    pgrep -f cloudflared

    echo "Docker containers:"
    docker ps --format "table {{.Names}}\t{{.Status}}"
  '';
}