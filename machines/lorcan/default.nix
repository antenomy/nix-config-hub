{ config, lib, pkgs, inputs, ... }:
# let 
  # path = import config/paths.nix;
  # token = import ../../secrets/secrets.nix;
  # homelab-setup = import path.HOMELAB_SETUP { inherit pkgs; };
# in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # path.HOMEPAGE_DASHBOARD_CONFIG
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.antenomy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];  # wheel = sudo access
    openssh.authorizedKeys.keys = [
      inputs.secrets.PC_SSH_KEY
      inputs.secrets.MACBOOK_SSH_KEY
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    cloudflared
    docker-compose
  ];

  programs.git = {
    enable = true;
  };  

  # systemd.user.services.run-on-startup = {
  #   description = "User startup script";
  #   after = [ "graphical-session.target" ];
  #   wantedBy = [ "default.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${homelab-setup}/bin/homelab-setup";
  #     RemainAfterExit = true;
  #   };
  # };

  systemd.user.services.cloudflared-startup = {
    description = "User startup script";
    after = [ "graphical-session.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      User = "antenomy";
      ExecStart = "cloudflared tunnel run --token ${inputs.secrets.A22_CLOUDFLARED_TO_WARP_TUNNEL}";
      RemainAfterExit = true;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [1918];
    settings = {
#      PermitRootLogin = "no";
      PasswordAuthentication = true;  # Allow password login
    };
  };

  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3000 8080 9443 ];

  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05"; # Did you read the comment?

}
