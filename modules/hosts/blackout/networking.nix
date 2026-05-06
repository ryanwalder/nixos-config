{ inputs, ... }: {
  flake.modules.nixos.blackout = {
    networking.hostName = "blackout";
    programs.mtr.enable = true;

    imports = [
      (inputs.self.factory.dhcp-interface { interface = "enp6s0"; })
    ];

    systemd.network.networks."40-enp5s0f0".linkConfig.RequiredForOnline = false;
    systemd.network.networks."40-enp5s0f1".linkConfig.RequiredForOnline = false;
  };
}
