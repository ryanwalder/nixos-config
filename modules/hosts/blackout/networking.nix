{ inputs, ... }: {
  flake.modules.nixos.blackout = {
    networking.hostName = "blackout";
    programs.mtr.enable = true;

    imports = [
      (inputs.self.factory.dhcp-interface { interface = "enp6s0"; })
    ];
  };
}
