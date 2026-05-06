{...}: {
  flake.modules.nixos.hardware_swap = {config, lib, ...}: {
    options.hardware.swap.mode = lib.mkOption {
      type = lib.types.enum ["regular" "hibernate" "none"];
      default = "none";
      description = "Swap mode: regular (random-encrypted), hibernate (persistent, sized for resume), or none";
    };

    config = lib.mkIf (config.hardware.swap.mode != "none") (
      let
        memResources = (lib.head config.hardware.facter.report.hardware.memory).resources;
        physMem = lib.findFirst (r: r.type == "phys_mem") {range = 0;} memResources;
        ramMiB = physMem.range / 1024 / 1024;
        ramGiB = ramMiB / 1024;
        hibernateMiB = (ramGiB + ramGiB / 8 + 1) * 1024;
      in {
        swapDevices = [
          {
            device = "/var/lib/swap";
            size =
              if config.hardware.swap.mode == "hibernate"
              then hibernateMiB
              else ramMiB;
            randomEncryption.enable = config.hardware.swap.mode == "regular";
          }
        ];
      }
    );
  };
}
