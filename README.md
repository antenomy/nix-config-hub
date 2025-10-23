# nix-config-hub
A hub for the configuration files of all my NixOS devices, such as my PC, home servers etc.

### Structure
The machines currently supported by this flake are:
- `aelin` nix-darwin managed main macOS laptop running on Apple Silicon used as daily driver
- `dorian` nixOS running on main stationary computer with AMD graphics and processor
- `manon` nix WSL client for main stationary computer Windows dual boot
- `lorcan` nixOS home server used for tunneling with Cloudflared, running automation scripts, wake on LAN, etc. 
- `elide` nixOS home server used for running homelab services like pihole, portainer, hosting, etc.
- `lysandra` external macOS laptop not mainly managed by any nix software, running on Apple Silicon 


### Basic Setup
---
For more detailed guides pertaining to the repo check [Guides](./docs/GUIDES.md). 

##### 1. Download
```
git clone git@github.com:antenomy/nix-config-hub.git ~/nix
``` 

##### 2. Build
To set up any new device using this nix flake run the setup script with the following command:
```
/usr/bin/env bash -c "~/nix/scripts/setup.sh"
```

### Updating Dotfiles
---
Make changes to dotfiles in the `~/nix/dotfiles` dir, then using the package [just](https://github.com/casey/just) already installed, navigate to the project dir `~/nix` and simply run:
```
just update-dotfiles
```
