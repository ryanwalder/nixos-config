{...}: {
  flake.modules.nixos.hardware_cpu-intel = {...}: {
    boot.kernelModules = ["kvm-intel"];
    hardware.graphics.enable = true;
  };
}
