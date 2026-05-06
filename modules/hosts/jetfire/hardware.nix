{...}: {
  flake.modules.nixos.jetfire = {
    hardware.facter.reportPath = ./facter.json;
    hardware.swap.mode = "hibernate";

    boot.initrd.availableKernelModules = [
      "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"
    ];

    fileSystems."/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
}
