# Pow wow woppa bing bong
{
  description = "Main config flake for the hub";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixpkgs-master.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyperland / Wayland related flakes
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... } @ inputs:
  let
    homeconfig = {pkgs, ...}: {
      # this is internal compatibility configuration 
      # for home-manager, don't change this!
      home.stateVersion = "23.05";
      # Let home-manager install and manage itself.
      programs.home-manager.enable = true;

      home.packages = with pkgs; [];

      home.sessionVariables = {
        EDITOR = "vim";
      };

      programs.zsh = {
        enable = true;
        shellAliases = {
          switch = "just --justfile ~/git/nix-config-hub/justfile";
          python = "python3";
        };
        sessionVariables = {
          PATH="/Users/antenomy/Library/Python/3.9/bin:$PATH";
        };
      };
    };
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        # ./modules/default.nix
        ./machines/dorian/default.nix
      ];
    };

    darwinConfigurations.aelin = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self nixpkgs inputs; };
      modules = [ 
        ./machines/aelin/default.nix 
        home-manager.darwinModules.home-manager  {
          # home-manager.homeDirectory = "/Users/antenomy";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.users.antenomy = homeconfig;
        }
      ];
    };
  };
}