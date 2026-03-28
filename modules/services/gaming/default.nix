{ inputs, ... }: {
  flake.modules.nixos.gaming = { pkgs, ... }: {
    imports = [
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      inputs.nix-gaming.nixosModules.platformOptimizations
    ];

    environment.systemPackages = with pkgs; [
      protontricks
      protonup-ng
    ];

    programs.steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
