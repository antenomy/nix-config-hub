# nix-config-hub

[![NixOS](https://img.shields.io/badge/NixOS-5277C3?logo=nixos&logoColor=fff)](#)
[![Cloudflare](https://img.shields.io/badge/Cloudflare-F38020?logo=Cloudflare&logoColor=white)](#)
[![Ollama](https://img.shields.io/badge/Ollama-fff?logo=ollama&logoColor=000)](#)
[![Nix](https://img.shields.io/badge/Nix-5277C3.svg?&logo=NixOS&logoColor=white)](#)
[![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=fff)](#)

A hub for the configuration files of all my nixOS devices, such as my PC, laptops, home servers etc.

## Structure

The machines currently supported by this flake are:
- `aelin` nix-darwin managed main macOS laptop running on Apple Silicon used as daily driver
- `dorian` nixOS running on main stationary computer with AMD graphics and processor
- `manon` nix WSL client for main stationary computer Windows dual boot
- `lorcan` nixOS home server used for tunneling, automations, networking, etc. 
- `elide` nixOS home server used for running homelab services like pihole, portainer, docker, etc.
- `lysandra` external macOS laptop not mainly managed by any nix software, running on Apple Silicon 


## Basic Setup

For more detailed guides pertaining to the repo check [Guides](./docs/GUIDES.md). 

#### 1. Download
```
git clone git@github.com:antenomy/nix-config-hub.git ~/nix
``` 

#### 2. Build
To set up any new device using this nix flake run the setup script with the following command:
```
/usr/bin/env bash -c "~/nix/scripts/setup.sh"
```

## Updating Dotfiles

Make changes to dotfiles in the `~/nix/dotfiles` dir, then using the package [just](https://github.com/casey/just) (already installed), navigate to the project dir `~/nix` and simply run:
```
just update-dotfiles
```
