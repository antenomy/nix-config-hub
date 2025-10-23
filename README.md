# nix-config-hub
A hub for the configuration files of all my NixOS devices, such as my PC, home servers etc.

### Structure
The machines currently supported by this flake are:
- `aelin` nix-darwin managed main macOS laptop used as daily driver
- `dorian` NixOS running on main stationary computer with powerful AMD specs 
- `manon` nix WSL client for main stationary computer Windows dual boot
- `lorcan` wyse thin client used for tunneling with Cloudflared, running automation scripts, wake on LAN, etc. 
- `elide` wyse thin client used for running homelab services like pihole, portainer, etc.
- `lysandra` external macOS laptop not mainly managed by any nix software 


### Basic Setup
For more detailed guides pertaining to the repo check [Guides](./docs/GUIDES.md). 

##### 1. Download
```
git clone git@github.com:antenomy/nix-config-hub.git ~/nix
``` 

##### 2. Build
Navigate to the project dir `~/nix`, then, if you have the package [just](https://github.com/casey/just) already installed, simply run:
```
just switch
```
Otherwise just will be installed in the build process but you will
```
sudo nixos-rebuild switch --flake .#setup
```

To only update dot files run:
```
just dot
```
