{ lib, ... }: {
  flake.modules.nixos.host-options = {
    options.host = {
      swap = lib.mkOption {
        type = lib.types.enum [ "regular" "hibernate" "none" ];
        default = "regular";
        description = "Swap mode: regular (random-encrypted), hibernate (persistent, sized for resume), or none";
      };
    };
  };
}
