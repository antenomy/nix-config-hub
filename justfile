# Variables
HOSTNAME:="$(hostname)"
SYSTEM:="$(uname)"

edit:
    #!/usr/bin/env bash
    vim machines/$HOSTNAME/default.nix

update-dotfiles:
    #!/usr/bin/env bash
    bash "$HOME/nix/scripts/just/update-dotfiles.sh"

switch-simple:
    #!/usr/bin/env bash
    if [ "$SYSTEM" == "Darwin" ]; then
        sudo nixos-rebuild switch --flake .
    else
        sudo darwin-rebuild switch --flake .

switch:
    #!/usr/bin/env bash
    bash "$HOME/nix/scripts/just/switch.sh"

push VAR="update":
    #!/usr/bin/env bash
    git add .
    git commit -m "{{VAR}}"
    git push
