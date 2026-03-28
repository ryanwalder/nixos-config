{ ... }: {
  flake.modules.nixos.swap = { config, lib, ... }: {
    swapDevices = lib.mkIf (config.host.swap != "none") (
      let
        memResources = (lib.head config.hardware.facter.report.hardware.memory).resources;
        physMem = lib.findFirst (r: r.type == "phys_mem") { range = 0; } memResources;
        ramMiB = physMem.range / 1024 / 1024;
        ramGiB = ramMiB / 1024;
        hibernateMiB = (ramGiB + ramGiB / 8 + 1) * 1024;
      in [{
        device = "/var/lib/swap";
        size = if config.host.swap == "hibernate" then hibernateMiB else ramMiB;
        randomEncryption.enable = config.host.swap == "regular";
      }]
    );
  };
}
