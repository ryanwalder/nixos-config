{ inputs, ... }: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "blackout";

  flake.modules.nixos.blackout = {
    imports = with inputs.self.modules.nixos; [
      base
      workstation
      gaming
      amd
      nvidia
      ssd
      swap
      ryan
    ];

    system.stateVersion = "25.11";
  };
}
