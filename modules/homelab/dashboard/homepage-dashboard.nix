
{ config, lib, pkgs, modulesPath, ... }:

let
  path = import config/paths.nix;
  network = import path.NETWORK;
in
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 3000;

    # environmentFile = "/etc/nixos/config/homepage-dashboard.env";
    allowedHosts = "*";

    # Add environment variables to allow your IP/hostname
    #environmentFile = "/etc/homepage-dashboard/environment";
    #environmentFile = builtins.toFile "homepage.env" "HOMEPAGE_VAR_ALLOWED_HOSTS=192.168.2.22:3000";

    # Minimal config to test
    settings = {
      title = "lorcan Dashboard";
      background = "https://images.unsplash.com/photo-1502790671504-542ad42d5189";
      cardBlur = "md";
      theme = "dark";
      headerStyle = "boxed";
      hideVersion = true;
    };

    services = [
      { 
        "Infra" = [
          {
            "Portainer" = {
              href = "https://192.168.2.22:9443";
              description = "Docker Management";
              icon = "portainer";
            };
          }
          {
            "Portainer" = {
              href = "https://192.168.2.22:9443";
              description = "Docker Management";
              icon = "docker";
            };
          }
        ];
      }
      {
        "Networking" = [
          {
            Zyxel = {
              href = "https://192.168.1.1";
              description = "Network Router";
              icon = "router";
            };
          }
          {
            Pi-Hole = {
              href = "http://192.168.2.22/admin";
              description = "Network DNS";
              icon = "pi-hole";
            };
          }
        ];
      }
    ];

    bookmarks = [
      {
        "Developer" = [
          {
            "Cloudflare Dashboard" = [
              {
                href = "https://dash.cloudflare.com/a738d19545ea7cbab1b677b2837d5bc2/home/domains";
                icon = "cloudflare";
              }
            ];
          }
        ];
      }
      {
        "" = [
          { # comment
            "ChatGPT" = [
              {
                href = "https://chatgpt.com/";
                icon = "chatgpt";
              }
            ];
          }
        ];
      }
      {
        "" = [
          {
            "Config Github Page" = [
              {
                href = "https://github.com/antenomy/nix-wyse-a22/";
                icon = "github-light";
              }
            ];
          }
        ];
      }
      {
        "" = [
          {
            "Nixos Packages" = [
              {
                href = "https://search.nixos.org/packages";
                icon = "nixos";
              }
            ];
          }
        ];
      }
    ];
  };
}