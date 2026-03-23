{ lib, inputs, ... }: {
  networking.hostName = "blackout";

  system.stateVersion = "25.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  imports = [
    ./audio.nix
    ./hardware.nix
    ./home.nix
    ./monitors.nix
    ./networking.nix
    ./swap.nix
    ./mounts.nix
    ../../modules/nixos/audio
    ../../modules/nixos/cpu/amd
    ../../modules/nixos/gpu/nvidia
    ../../roles/base
    ../../roles/gaming
    ../../roles/home
    ../../roles/workstation
    ../../users/ryan
  ];
}
