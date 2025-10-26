{
  self, 
  config, 
  pkgs, 
  lib, 
  inputs, 
  ... 
}:
{
  environment.systemPackages = with pkgs; [
    # Basic
    vim
    brave
    cloudflared
    just
    neofetch
    detect-secrets
    wakeonlan

    # Privacy
    bitwarden-desktop

    # Dev
    # vscode
    ollama

    # Communication
    zoom-us
    discord

    # Media
    spotify

    # Nix
    nixfmt
  ];
}