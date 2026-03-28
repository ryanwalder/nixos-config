{ inputs, lib, ... }: {
  flake.modules.nixos.nvidia = { config, ... }: let
    cfg = config.hardware.nvidia;

    gpuNumber = lib.strings.toInt (
      lib.strings.concatStrings (
        builtins.filter (c: builtins.match "[0-9]" c != null)
        (lib.strings.stringToCharacters cfg.gpu)
      )
    );

    generation =
      if gpuNumber >= 4000 then "ada"
      else if gpuNumber >= 3000 then "ampere"
      else if gpuNumber >= 1600 then "turing"
      else "legacy";

    useOpenDrivers = generation != "legacy";
  in {
    imports = [ inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime ];

    options.hardware.nvidia.gpu = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "rtx3080";
      description = "NVIDIA GPU model (e.g., rtx3080, gtx1660, rtx4090)";
    };

    config = lib.mkMerge [
      { hardware.nvidia.powerManagement.enable = true; }
      (lib.mkIf (cfg.gpu != null) {
        hardware.nvidia.open = useOpenDrivers;
      })
    ];
  };
}
