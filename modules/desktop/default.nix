{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hyprland.nix
    # ./wayland.nix
  ];

    
  home.packages = with pkgs; [
  ];
}