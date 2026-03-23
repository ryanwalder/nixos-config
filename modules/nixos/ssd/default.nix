{ inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
}
