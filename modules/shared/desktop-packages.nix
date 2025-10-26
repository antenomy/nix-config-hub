{
  pkgs, 
  ... 
}:
{
  environment.systemPackages = with pkgs; [
    # Basic
    brave

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