{ ... }: {
  config.flake.factory.pci-stub-bind = { vendor, device }: {
    boot.kernelModules = [ "pci-stub" ];
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="${vendor}", ATTR{device}=="${device}", ATTR{driver_override}="pci-stub"
    '';
  };
}
