{ config, lib, pkgs, inputs, ... }:
let
  aelinSSHKey = builtins.getEnv "AELIN_SSH_KEY";
  dorianSSHKey = builtins.getEnv "DORIAN_SSH_KEY";
in
{
  imports =
    [
      ./hardware.nix
      # path.HOMEPAGE_DASHBOARD_CONFIG
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.antenomy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];  # wheel = sudo access
    openssh.authorizedKeys.keys = [
      dorianSSHKey
      aelinSSHKey
    ];
  };

  environment.systemPackages = with pkgs; [
    # Basic

    # Developer
    docker-compose
  ];

  programs.git = {
    enable = true;
  };  

  networking = {
    hostName = "lorcan";
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


  # FIX DOESNT WORK
  systemd.user.services.cloudflared-startup = {
    description = "User startup script";
    after = [ "graphical-session.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      User = "antenomy";
      ExecStart = "cloudflared tunnel run lorcan-ssh";
      RemainAfterExit = true;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [1918];
    settings = {
      PasswordAuthentication = true;  # Allow password login
    };
      extraConfig = ''
PubkeyAuthentication yes
'';
  };

  #TrustedUserCAKeys /etc/ssh/ca.pub
  
  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3000 8080 9443 ];

  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05"; # Did you read the comment?

}
