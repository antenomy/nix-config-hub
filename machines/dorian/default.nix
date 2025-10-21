{ config, pkgs, lib, inputs, ... }:
let 
  wifiPassword = builtins.getEnv "WIFI_PASSWORD";
  aelinSSHKey = builtins.getEnv "AELIN_SSH_KEY";
in
{
  imports = [ 
    ./hardware.nix
    inputs.home-manager.nixosModules.home-manager
    # inputs.hyprland.nixosModules.hyprland
  ];


  # User Account
  users.users.antenomy = {
    isNormalUser = true;
    description = "antenomy";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    openssh.authorizedKeys.keys = [
      aelinSSHKey
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

 
  # Home Manager
  home-manager.users.antenomy = import ./home.nix {
    pkgs = pkgs;
    lib = lib;
  };

  home-manager.backupFileExtension = "backup";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true ;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };


  # Systemd
  systemd.services.cloudflared = {
    description = "Cloudflare Tunnel";
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = "/home/antenomy/.local/bin/cloudflared tunnel run nix-pc";
      Restart = "on-failure";
      User = "antenomy";  # replace with your username
      WorkingDirectory = "/home/antenomy";
      Environment = "PATH=/home/antenomy/.local/bin:/usr/bin:/bin"; # ensure cloudflared is found
    };

    wantedBy = [ "multi-user.target" ];
  };
  

  # Ollama
  services.ollama = {
    enable = true;
    acceleration = "rocm";
   
    # Optional: preload models, see https://ollama.com/library
    loadModels = [
      "deepseek-r1:1.5b"
      "deepseek-r1:8b"
      "deepseek-r1:32b"
      "deepseek-r1:70b"
      
      "qwen3:32b"
      "devstral:24b" 

      "mistral-small:24b"
      "dolphin-mixtral:latest" 
    ];
    #rocmOverrideGfx = 11.0.0;
  };


  # SSH
  services.openssh = {  
    enable = true;  
    ports = [1918];
    settings = {
      PasswordAuthentication = true;
    };
  };


  # Desktop Environment
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "hyprland > /dev/null 2>&1";
        user = "antenomy";
      };
      default_session = initial_session;
    };
  };

  services.xserver.xkb = {
    layout = "uk";
    variant = "nodeadkeys";
  };


  services.hardware.openrgb.enable = true;


  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Network
  networking = {
    hostName = "dorian";
    wireless = {
      enable = true;
      networks = {
        "Cloudy Bay downstairs" = {
          psk = "Get Funky";
        };
      };
    };
    interfaces.eth0.wakeOnLan.enable = true;
  };

  
  # Settings
  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";
  services.printing.enable = true;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

#  programs.nix-ld.enable = true;
#
#  programs.nix-ld.libraries = with pkgs; [
#    glibc
#    zlib
#    openssl
#    curl
#    libgcc
#    stdenv.cc.cc
#  ];
  

  environment.systemPackages = with pkgs; [
    # General
    vim 
    kitty    
    brave
    rofi
    xfce.thunar
    unzip
    neofetch
    nwg-look
    veracrypt
    ethtool
    htop
    amdgpu_top

    # Desktop Environment	
    hyprland
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    dconf
    dconf-editor
    mako
    waybar
    wofi
    pavucontrol
    hyprlock
    hyprshade
    
    # Customization
    swww
    mpvpaper
    hyprcursor
    
    # Development
    # vscode
    code-cursor-fhs
    cloudflared
    wget
    ollama
    rocmPackages.clr
    clinfo
    just

    # Productivity
    notion-app-enhanced
    obsidian
    dropbox

    # Social
    discord
    
    # Leisure
    #spotify
   
    # Creative
    gimp3-with-plugins
  ];
  
  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
    #(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly"];})
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.git = {
    enable = true;
    #userName = "antenomy";
    #userEmail = "lucas.grant@gmail.com";
  };
  
  programs.direnv.enable = true;
 
  virtualisation.docker = {
    enable = true;

    # Optional: If you're using flakes or systemd-boot, you may also want:
    rootless.enable = true;
  };

  # Customization
  #gtk = {
  #  enable = true;
  #  theme = {
  #    name = "Adwaita";
  #    package = pkgs.adwaita-gtk3;  # Dark variant included
  #  };
  #  iconTheme = {
  #    name = "Papirus-Dark";
  #    package = pkgs.papirus-icon-theme;
  #  };
  #  gtk3.extraConfig = {
  #    Settings = ''
  #      gtk-application-prefer-dark-theme=1
  #    '';
  #  };
  #  gtk4.extraConfig = {
  #    Settings = ''
  #      gtk-application-prefer-dark-theme=1
  #    '';
  #  };
  #};



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
