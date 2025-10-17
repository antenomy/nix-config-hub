{ self, config, pkgs, lib, inputs, ... }: #config, pkgs, lib, 

{
  system.primaryUser = "antenomy";

  nixpkgs.config = {
    allowUnfree = true;
  };

  networking = {
    hostName = "aelin";
    computerName = "aelin";
  };

  users.users.antenomy = {
    name = "antenomy";
    home = "/Users/antenomy";
  };


  security.pam.services.sudo_local.touchIdAuth = true;


  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # General
    iterm2
    vim
    neofetch

    # Privacy
    bitwarden-desktop

    # Productivity
    # notion-app-enhanced
    raycast
    chatgpt

    # Developer
    vscode
    code-cursor
    neovim

    docker
    docker-compose
    direnv
    cloudflared
    just
    ollama
    ffmpeg_8

    python311
    python310

    # Communication
    zoom-us
    whatsapp-for-mac
    discord

    # Media
    spotify
    
  ];

  homebrew = {
    enable = true;
    # onActivation.cleanup = "uninstall";

    taps = [];
    brews = [
      "yt-dlp"
    ];
    casks = [

      # General
      "dropbox"
      "disk-inventory-x"

      # Privacy
      "veracrypt"

      # Productivity
      "figma"
      "obsidian"
      "notion-enhanced"
      
      # "notion"

      # Developer
      "cloudflare-warp"
      "docker-desktop"
      "macfuse"

      # Communication
      "mattermost"
    ];
  };

  
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
