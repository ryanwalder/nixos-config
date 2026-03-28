{ ... }: {
  flake.modules.nixos.amd = { ... }: {
    boot.kernelModules = [ "kvm-amd" ];
    boot.kernelParams = [ "amd_pstate=active" ];
  };
}
