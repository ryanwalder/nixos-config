hostname := `hostname`
uid := `id -u`
gid := `id -g`

# Apply configuration for the current host
switch:
    sudo nixos-rebuild switch --flake .#{{ hostname }}

# Build without applying
build:
    nixos-rebuild build --flake .#{{ hostname }}

# Test configuration (applies but reverts on reboot)
test:
    sudo nixos-rebuild test --flake .#{{ hostname }}

# Apply configuration on next boot
boot:
    sudo nixos-rebuild boot --flake .#{{ hostname }}

# Update flake inputs
update:
    nix flake update

# Update and switch
upgrade: update switch

# Generate facter config for host
facter host=hostname:
    mkdir -p modules/hosts/{{ host }}
    sudo nix run \
      nixpkgs#nixos-facter -- \
      -o modules/hosts/{{ host }}/facter.json
    sudo chown {{ uid }}:{{ gid }} modules/hosts/{{ host }}/facter.json

# Manage sops secrets (add, remove, edit, update)
sops *args:
    ./scripts/sops.py "{{ justfile_directory() }}" {{ args }}
