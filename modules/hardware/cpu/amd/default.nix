{...}: {
  flake.modules.nixos.hardware_cpu-amd = {...}: {
    boot.kernelModules = ["kvm-amd"];
    boot.kernelParams = ["amd_pstate=active"];
  };
}
