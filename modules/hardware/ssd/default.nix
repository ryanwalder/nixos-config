{ ... }: {
  flake.modules.nixos.hardware_ssd = { ... }: {
    services.fstrim = {
      enable = true;
      interval = "weekly";
    };
  };
}
