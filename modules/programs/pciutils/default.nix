{...}: {
  flake.modules.nixos.program_pciutils = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      pciutils
    ];
  };
}
