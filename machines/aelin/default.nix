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

    # Basic

    # Privacy
    
    # Productivity
    chatgpt

    # Desktop Environment
    sketchybar
    aerospace

    # Developer
    iterm2
    vscode
    code-cursor
    neovim

    docker
    docker-compose

    ffmpeg_8

    python311
    python310

    # Not currently using
    # whatsapp-for-mac
    # jankyborders
    # notion-enhanced-app
    # betterdisplay
  ];


  homebrew = {
    enable = true;
    # onActivation.cleanup = "uninstall";

    # ADD MACSTORE APPS

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
      "raycast"
      "figma"
      "obsidian"
      "notion"
      # "notion-enhanced"

      # Communication
      "whatsapp"

      # "sf-symbols"
      # Fonts
      "font-material-symbols"
      "font-material-icons"
      "font-sf-mono"
      "sf-symbols"
      "font-0xproto"
      "font-0xproto-nerd-font"
      # "notion"

      # Developer
      "cloudflare-warp"
      "docker-desktop"
      "macfuse"

      # RETU8RN TO OLD MENU BAR RETU8RN TO OLD MENU BAR RETU8RN TO OLD MENU BAR RETU8RN TO OLD MENU BARRETU8RN TO OLD MENU BAR RETU8RN TO OLD MENU BAR RETU8RN TO OLD MENU BAR RETU8RN TO OLD MENU BAR

      # Communication
      "mattermost"
    ];
  };

  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
  ];

  programs.direnv.enable = true;
  
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
