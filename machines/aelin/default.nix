{ self, config, pkgs, lib, inputs, ... }: #config, pkgs, lib, 

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  networking = {
    hostName = "aelin";
    computerName = "aelin";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # General
    iterm2
    vim
    neofetch

    # Privacy
    bitwarden-desktop
    # veracrypt

    # Developer
    raycast
    chatgpt

    vscode
    code-cursor
    direnv
    just
    ollama

    # Communication
    # mattermost
    zoom-us
    whatsapp-for-mac

    # Media
    spotify
  ];

  
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
