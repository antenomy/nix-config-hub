# nix-config-hub
A hub for the configuration files of all my NixOS devices, such as my PC, home servers etc.






### Structure
The machines currently supported by this flake are:
- `aelin` nix-darwin managed main macbook air used as daily driver
- `dorian` NixOS running on main stationary computer with powerful AMD specs 
- `manon` nix WSL client for main stationary computer Windows dual boot
- `lorcan` wyse thin client used for running homelab services like pihole, portainer etc.


### Basic Setup
For a more expanisve guide check [Guides](./docs/GUIDES.md). To run, make sure to have the package [Just](https://github.com/casey/just) installed, and then navigate to the project dir and run:

```
just switch
```

To only update dot files run:
```
just dot
```
