switch:
  sudo cp ./flake.nix /etc/nixos

  sudo cp -r ./machines /etc/nixos

  sudo cp -r ./modules /etc/nixos

  sudo nixos-rebuild switch --flake /etc/nixos