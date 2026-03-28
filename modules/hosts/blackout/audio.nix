{ inputs, ... }: {
  flake.modules.nixos.blackout = {
    imports = [
      (inputs.self.factory.pci-stub-bind { vendor = "0x10de"; device = "0x1aef"; })
      (inputs.self.factory.pci-stub-bind { vendor = "0x1022"; device = "0x1487"; })
    ];
  };
}
