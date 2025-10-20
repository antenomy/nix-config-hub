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
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... } @ inputs:
  let
    lib = nixpkgs.lib;

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

      # programs.vscode {
      #   # ...

      #   userSettings = {
      #     # ...
      #     "workbench.colorTheme" = "Dracula Theme";
      #   };

      #   # ...

      #   extensions = with pkgs.vscode-marketplace; [
      #     jnoortheen.nix-ide
      #     theme-dracula
      #   ];
      # }

      programs.zsh = {
        enable = true;
        shellAliases = {
          switch = "just --justfile ~/git/nix-config-hub/justfile";
          python = "python3";
        };

        sessionVariables = {
          PATH = lib.concatStringsSep ":" [
            "/Users/antenomy/Library/Python/3.9/bin"
            "/run/current-system/sw/bin"
            "$PATH"
          ];
        };

        localVariables = {
          PS1 = "%~ > ";

          # PS1="$USER@$(hostname) $PATH > ";
        };
      };
    };
  in
  {
    # Dorian
    nixosConfigurations.dorian = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        # ./modules/default.nix
        ./machines/dorian/default.nix
      ];
    };

    # Lorcan
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        # ./modules/default.nix
        ./machines/lorcan/nixos/configuration.nix
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
