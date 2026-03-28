{ inputs, ... }: {
  flake.modules.nixos.workstation = { pkgs, ... }: {
    imports = with inputs.self.modules.nixos; [
      i3
      audio
      gnupg
      printing
      printing-office
    ];

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    services.blueman.enable = true;

    environment.systemPackages = with pkgs; [
      qimgv
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.workstation ];
  };
}
