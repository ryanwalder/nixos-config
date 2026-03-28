{ ... }: {
  flake.modules.nixos.blackout = {
    hardware.facter.reportPath = ./facter.json;
    host.swap = "regular";
    hardware.nvidia.gpu = "rtx3080";

    boot.initrd.availableKernelModules = [
      "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"
    ];

    fileSystems."/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };
}
