{inputs, ...}: {
  flake.modules.nixos.jetfire = {
    networking.hostName = "jetfire";

    imports = [
      (inputs.self.factory.dhcp-interface {interface = "wlp0s20f3";})
    ];
  };
}
