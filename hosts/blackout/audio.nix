{ config, ... }: {
  boot.kernelModules = [ "pci-stub" ];

  # Disable NVIDIA & Onboard Sound
  services.udev.extraRules = ''
    # Disable NVIDIA/Onboard sound
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{device}=="0x1aef", ATTR{driver_override}="pci-stub"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1022", ATTR{device}=="0x1487", ATTR{driver_override}="pci-stub"
  '';
}
