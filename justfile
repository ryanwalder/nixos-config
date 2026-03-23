hostname := `hostname`

# Apply configuration for the current host
switch:
    sudo nixos-rebuild switch --flake .#{{hostname}}

# Build without applying
build:
    nixos-rebuild build --flake .#{{hostname}}

# Test configuration (applies but reverts on reboot)
test:
    sudo nixos-rebuild test --flake .#{{hostname}}

# Update flake inputs
update:
    nix flake update

# Update and switch
upgrade: update switch
