{ config, lib, pkgs, ... }: {
  imports = [
    ./filesystem.nix
    ./firmware.nix
    ./firewall.nix
    ./ssh.nix
    ./boot.nix
    ./nix.nix
    ./kernel.nix
    ./locale.nix
    ./packages.nix
    ./sudo.nix
    ../../modules/nixos/ssd
  ];
}
