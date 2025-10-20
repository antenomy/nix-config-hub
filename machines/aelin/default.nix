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
    # raycast
    chatgpt
    # yabai

    # Customization
    # jankyborders
    sketchybar
    aerospace
    # _0xproto

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
    # whatsapp-for-mac
    discord

    # Media
    spotify
    
  ];


  # betterdisplay

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

  # launchd = {
  #   user = {
  #     agents = {
  #       startup-daemon = {
  #         command = "bash ~/git/nix-config-hub/scripts/darwin/startup-script.sh";
  #         serviceConfig = {
  #           KeepAlive = false;
  #           RunAtLoad = true;
  #           StandardOutPath = "/tmp/yabai-daemon.out.log";
  #           StandardErrorPath = "/tmp/yabai-daemon.err.log";
  #         };
  #       };
  #     };
  #     # agents = {
  #     #   sketchybar-daemon = {
  #     #     command = "sketchybar";
  #     #     serviceConfig = {
  #     #       KeepAlive = true;
  #     #       RunAtLoad = true;
  #     #       StandardOutPath = "/tmp/sketchybar-daemon.out.log";
  #     #       StandardErrorPath = "/tmp/sketchybar-daemon.err.log";
  #     #     };
  #     #   };
  #     # };
  #   };
  # };

  # programs.launchd = {
  #   # Enable launchd support
  #   enable = true;

  #   # Define your startup jobs
  #   jobs = {
  #     myApp = {
  #       program = "/bin/sh"; # path to executable
  #       arguments = ["-c" "yabai"];
  #       runAtLoad = true;   # start on login
  #       keepAlive = true;  # restart if crashes (optional)
  #     };

  #     # anotherService = {
  #     #   program = "/usr/local/bin/my-script.sh";
  #     #   runAtLoad = true;
  #     #   keepAlive = true;
  #     # };
  #   };
  # };

  
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
